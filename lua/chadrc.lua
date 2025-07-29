local configs = require("lsp_config")

function _G.ReloadNvChadConfig()
    -- Clear cached modules from package.loaded
    for name, _ in pairs(package.loaded) do
        if name:match("^custom") or name:match("^core") or name:match("^base46") then
            package.loaded[name] = nil
        end
    end
    -- Reload chadrc configuration
    dofile(vim.fn.stdpath("config") .. "/lua/chadrc.lua")
    -- Reload UI components if possible
    pcall(function()
        require("base46").load_all_highlights()
    end)
    vim.cmd("redraw")
    print("NvChad configuration reloaded!")
end

vim.api.nvim_create_user_command("ReloadNvChad", ReloadNvChadConfig, {})

local servers = {
    html = {},
    cssls = {},
    clangd = {},
    bashls = {},
    lua_ls = {},
    ts_ls = {},
    nil_ls = {},
    rust_analyzer = {},
    kotlin_language_server = {},

    pyright = {
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    typeCheckingMode = "basic",
                },
            },
        },
    },
}

for name, opts in pairs(servers) do
    opts.on_init = configs.on_init
    opts.on_attach = configs.on_attach
    opts.capabilities = configs.capabilities

    require("lspconfig")[name].setup(opts)
end

local options = {

    base46 = {
        theme = "aquarium",
        hl_add = {},
        integrations = {},
        changed_themes = {
            aquarium = {
                base_16 = {
                    base00 = '#20202A', -- background
                    base01 = '#3b3b4d', -- lighter background (used for status bars, line number bg, etc.)
                    base02 = '#44495E', -- selection background
                    base03 = '#63718B', -- comments, invisibles, line highlighting
                    base04 = '#C6D0E9', -- dark foreground (used for status bars)
                    base05 = '#63718B', -- default foreground, caret, delimiters, operators
                    base06 = '#C6D0E9', -- light foreground (not often used)
                    base07 = '#E5E9F0', -- light background (not often used)
                    base08 = '#ebb9b9', -- variables, XML tags, markup link text, markup lists, diff deleted
                    base09 = '#ebe3b9', -- integers, boolean, constants, XML attributes, markup link url
                    base0A = '#ebe3b9', -- classes, markup bold, search text background
                    base0B = '#caf6bb', -- strings, inherited class, markup code, diff inserted
                    base0C = '#b8dceb', -- support, regular expressions, escape characters, markup quotes
                    base0D = '#cddbf9', -- functions, methods, attribute IDs, headings
                    base0E = '#f6bbe7', -- keywords, storage, selector, markup italic, diff changed
                    base0F = '#cc9b9d', -- deprecated, opening/closing embedded language tags
                },
                base_30 = {
                    white = '#C6D0E9',
                    darker_black = '#1a1a22',
                    black = '#20202A',        -- main background
                    black2 = '#242430',       -- slightly lighter than bg
                    one_bg = '#2a2a36',       -- one step lighter
                    one_bg2 = '#323240',      -- two steps lighter
                    one_bg3 = '#3a3a48',      -- three steps lighter
                    grey = '#44495E',         -- for borders, inactive elements
                    grey_fg = '#4a4f64',      -- slightly lighter grey
                    grey_fg2 = '#505570',     -- even lighter grey
                    light_grey = '#5a5f74',
                    red = '#ebb9b9',
                    baby_pink = '#f6bbe7',
                    pink = '#cc9b9d',
                    line = '#2C2E3E',         -- for indent lines, etc.
                    green = '#caf6bb',
                    vibrant_green = '#a3ccad',
                    blue = '#cddbf9',
                    nord_blue = '#B8C9EA',
                    yellow = '#ebe3b9',
                    sun = '#d1ba97',
                    purple = '#f6bbe7',
                    dark_purple = '#c497b3',
                    teal = '#b8dceb',
                    orange = '#ebe3b9',
                    cyan = '#95C2D1',
                    statusline_bg = '#242430',
                    lightbg = '#2a2a36',
                    pmenu_bg = '#cddbf9',
                    folder_bg = '#cddbf9',
                }
            },
        },
        transparency = false,
    },

    ui = {
        cmp = {
            icons_left = true,
            lspkind_text = true,
            style = "flat_dark",
            format_colors = {
                tailwind = true,
                icon = "󱓻",
            },
        },
        telescope = { style = "borderless" },
        tabufline = {
            enabled = false,
            lazyload = true,
            order = { "treeOffset", "buffers", "tabs", "btns" },
            modules = nil,
        },
    },

    term = {
        winopts = { number = false, relativenumber = false },
        sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
        float = {
            relative = "editor",
            row = 0.3,
            col = 0.1,
            width = 0.8,
            height = 0.9,
            border = "single",
        },
    },

    lsp = { signature = true },

    mason = { pkgs = {} },

    colorify = {
        enabled = false,
        mode = "virtual",
        virt_text = "󱓻 ",
        highlight = { hex = true, lspvars = true },
    },
}

local status, chadrc = pcall(require, "chadrc")
return vim.tbl_deep_extend("force", options, status and chadrc or {})
