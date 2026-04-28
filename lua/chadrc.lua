-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(
local M                    = {}
local generated_theme_path = vim.fn.expand("~/.config/nvim/generated_theme.lua");
local generated_theme      = nil;

if vim.fn.filereadable(generated_theme_path) == 1 then
    local ok, theme = pcall(dofile, generated_theme_path);
    if ok then
        generated_theme = theme;
    end;
end;

M = {
    base46 = {
        theme = "chadtain",
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
                    black = '#20202A',    -- main background
                    black2 = '#242430',   -- slightly lighter than bg
                    one_bg = '#2a2a36',   -- one step lighter
                    one_bg2 = '#323240',  -- two steps lighter
                    one_bg3 = '#3a3a48',  -- three steps lighter
                    grey = '#44495E',     -- for borders, inactive elements
                    grey_fg = '#4a4f64',  -- slightly lighter grey
                    grey_fg2 = '#505570', -- even lighter grey
                    light_grey = '#5a5f74',
                    red = '#ebb9b9',
                    baby_pink = '#f6bbe7',
                    pink = '#cc9b9d',
                    line = '#2C2E3E', -- for indent lines, etc.
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
            everblush = generated_theme and generated_theme.everblush or {
                base_16 = {
                    base00 = '#0e1416', -- background
                },
            },
            chadtain = {
                base_16 = {
                    base00 = '#131C19', -- background
                    base01 = '#1a2622', -- lighter background (used for status bars, line number bg, etc.)
                    base02 = '#222e2b', -- selection background
                    base03 = '#2c382d', -- comments, invisibles, line highlighting
                    base04 = '#3c474a', -- dark foreground (used for status bars)
                    base05 = '#444F4C', -- default foreground, caret, delimiters, operators
                    base06 = '#525F5A', -- light foreground (not often used)
                    base07 = '#606F68', -- light background (not often used)
                    base08 = '#735959', -- variables, XML tags, markup link text, markup lists, diff deleted
                    base09 = '#7a573f', -- integers, boolean, constants, XML attributes, markup link url
                    base0A = '#4e4737', -- classes, markup bold, search text background
                    base0B = '#395242', -- strings, inherited class, markup code, diff inserted
                    base0C = '#4c685f', -- support, regular expressions, escape characters, markup quotes
                    base0D = '#41575c', -- functions, methods, attribute IDs, headings
                    base0E = '#5e526a', -- keywords, storage, selector, markup italic, diff changed
                    base0F = '#4e3837', -- deprecated, opening/closing embedded language tags
                },
                base_30 = {
                    white = '#444F4C',
                    darker_black = '#0d1513',
                    black = '#131C19',    -- main background
                    black2 = '#1a2622',   -- slightly lighter than bg
                    one_bg = '#1f2b27',   -- one step lighter
                    one_bg2 = '#242f2c',  -- two steps lighter
                    one_bg3 = '#293431',  -- three steps lighter
                    grey = '#2c382d',     -- for borders, inactive elements
                    grey_fg = '#323d39',  -- slightly lighter grey
                    grey_fg2 = '#38433f', -- even lighter grey
                    light_grey = '#3e4845',
                    red = '#735959',
                    baby_pink = '#5e526a',
                    pink = '#4e3837',
                    line = '#1f2b27', -- for indent lines, etc.
                    green = '#395242',
                    vibrant_green = '#2c3f33',
                    blue = '#41575c',
                    nord_blue = '#324448',
                    yellow = '#7a573f',
                    sun = '#4e4737',
                    purple = '#5e526a',
                    dark_purple = '#373e4e',
                    teal = '#4c685f',
                    orange = '#7a573f',
                    cyan = '#374c4e',
                    statusline_bg = '#1a2622',
                    lightbg = '#1f2b27',
                    pmenu_bg = '#41575c',
                    folder_bg = '#41575c',
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
        enabled = true,
        mode = "virtual",
        virt_text = "󱓻 ",
        highlight = { hex = true, lspvars = true },
    },
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }

return M
