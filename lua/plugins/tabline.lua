-- Lualine keeps its own copy of the theme table it is given at setup(), so the
-- table has to be rebuilt and passed again on every theme switch. Colors are
-- read from base46 each time this runs, not once when the file is loaded.
local function setup_lualine()
    local base46  = require("base46");
    local base_16 = base46.get_theme_tb("base_16");
    local base_30 = base46.get_theme_tb("base_30");

    local bubbles_theme = {
        normal = {
            a = { fg = base_30.white, bg = base_16.base00 },
            b = { fg = base_30.grey_fg, bg = base_16.base00 },
            c = { fg = base_30.grey_fg, bg = base_16.base00 },
        },

        insert = { a = { fg = base_30.black, bg = base_30.blue } },
        visual = { a = { fg = base_30.black, bg = base_30.cyan } },
        replace = { a = { fg = base_30.black, bg = base_30.red } },

        inactive = {
            a = { fg = base_30.grey_fg, bg = base_16.base00 },
            b = { fg = base_30.grey_fg, bg = base_16.base00 },
            c = { fg = base_30.grey_fg, bg = base_16.base00 },
        },
    }

    require('lualine').setup {
        options = {
            theme = bubbles_theme,
            component_separators = '',
            -- section_separators = { left = '', right = '' },
            always_show_tabline = true,
        },
        sections = {
            -- lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
            -- lualine_b = { 'filename', 'branch' },
            -- lualine_c = {
            --     '%=', --[[ add your center components here in place of this comment ]]
            -- },
            -- lualine_x = {},
            -- lualine_y = { 'filetype', 'progress' },
            -- lualine_z = {
            --     { 'location', separator = { right = '' }, left_padding = 2 },
            -- },
        },
        inactive_sections = {
            -- lualine_a = { 'filename' },
            -- lualine_b = {},
            -- lualine_c = {},
            -- lualine_x = {},
            -- lualine_y = {},
            -- lualine_z = { 'location' },
        },
        tabline = {
            lualine_a = { {
                'buffers',
                right_padding = 2,
                mode = 0,
                path = 0,

                symbols = {
                    modified = ' ●',      -- Text to show when the buffer is modified
                    alternate_file = '', -- Text to show to identify the alternate file
                    directory =  '',     -- Text to show when the buffer is a directory
                },
            } },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {}
        },
        extensions = {},
    }
end

return {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
        setup_lualine()

        -- Fired by _G.reload_nvchad_theme() (chadrc.lua) after the new
        -- highlights are loaded.
        vim.api.nvim_create_autocmd("User", {
            group    = vim.api.nvim_create_augroup("LualineThemeReload", { clear = true }),
            pattern  = "ThemeReloaded",
            callback = setup_lualine,
        })
    end
}
