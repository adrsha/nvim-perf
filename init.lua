vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

require "options"
require "mappings"


-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({

    { import = "plugins" },
}, lazy_config)

-- load theme
-- pcall: on a first launch the cache does not exist yet. chadrc.lua compiles
-- it right after startup, so a missing file must not abort the config.
pcall(dofile, vim.g.base46_cache .. "defaults")
pcall(dofile, vim.g.base46_cache .. "statusline")
require "autocmds"

-- live theme switching: reload whenever theme-daemon republishes active.json
require("theme_state").watch(function()
    require "chadrc" -- makes sure _G.reload_nvchad_theme is defined
    _G.reload_nvchad_theme()
end)
