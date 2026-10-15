-- theme_state.lua
--
-- Single source of truth for the active theme inside nvim.
--
-- Reads ~/.local/state/theme/active.json (published atomically by
-- theme-daemon on every switch) instead of THEME_* environment variables.
-- Environment variables are copied into a process at launch, so a running
-- terminal/shell keeps the OLD values after `theme-set`; the JSON file never
-- goes stale. The env vars are only used as a fallback.
local M = {}

local dir  = (vim.env.HOME or "") .. "/.local/state/theme"
local path = dir .. "/active.json"

local snapshot = nil

local function read()
    local f = io.open(path, "r")
    if not f then return nil end
    local s = f:read("*a")
    f:close()
    local ok, data = pcall(vim.json.decode, s)
    if ok and type(data) == "table" then return data end
    return nil
end

function M.refresh()
    snapshot = read()
    return snapshot
end

local function snap()
    if snapshot == nil then M.refresh() end
    return snapshot
end

-- Resolved value of a theme key (e.g. "BASE00"), or nil.
-- With a valid snapshot ONLY the snapshot is used: a key missing from it is
-- reported as missing instead of being filled from (possibly stale) env vars,
-- so the palette is never a mix of two themes. The env vars are used only
-- when there is no snapshot at all.
function M.get(key)
    local d = snap()
    local v
    if d and type(d.values) == "table" then
        v = d.values[key]
    else
        v = vim.env["THEME_" .. key]
    end
    if v == "" then v = nil end
    return v
end

function M.variant()
    local d = snap()
    return (d and d.variant) or vim.env.THEME_VARIANT or "dark"
end

-- Resolved transparency (includes the `theme-set --transparent` override).
-- active.json publishes it as `opacity`; 1 means opaque.
function M.transparent()
    local d = snap()
    if d and type(d.opacity) == "number" then return d.opacity < 1 end
    return vim.env.THEME_TRANSPARENT == "true"
end

-- Call `on_change` whenever theme-daemon republishes active.json.
-- The daemon replaces the file atomically (rename), so the directory is
-- watched, not the file.
function M.watch(on_change)
    if M._handle or not vim.uv.fs_stat(dir) then return end
    local handle = vim.uv.new_fs_event()
    local timer  = vim.uv.new_timer()
    if not handle or not timer then return end

    local ok = handle:start(dir, {}, function(err, fname)
        if err or fname ~= "active.json" then return end
        timer:stop() -- debounce bursts of events
        timer:start(100, 0, vim.schedule_wrap(function()
            M.refresh()
            on_change()
        end))
    end)
    if ok == nil or ok == false then return end
    M._handle, M._timer = handle, timer -- keep references alive
end

return M
