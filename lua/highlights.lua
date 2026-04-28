local lightenColor         = require("utils/colors").lightenColor;
local darkenColor          = require("utils/colors").darkenColor;
local mergeColors          = require("utils/colors").mergeColors;
local base46               = require("base46");

local base_16              = base46.get_theme_tb("base_16");
local base_30              = base46.get_theme_tb("base_30");

local transparency_enabled = vim.g.transparency or false;

-- Solid fallback derived from theme palette
local fallback_solid_bg    = tonumber("0x" .. base_30.darker_black:sub(2));
local normal_bg_raw        = vim.api.nvim_get_hl(0, { name = "Normal" }).bg;
local normal_bg            = (transparency_enabled and not normal_bg_raw)
    and fallback_solid_bg
    or (normal_bg_raw or fallback_solid_bg);
local float_bg_raw         = vim.api.nvim_get_hl(0, { name = "NormalFloat" }).bg;
local float_bg             = float_bg_raw or normal_bg;
local telescope_border_bg  = vim.api.nvim_get_hl(0, { name = "TelescopeBorder" }).bg or float_bg;

-- Colors sourced directly from the chadrc theme palette
local function hex(h)
    return tonumber("0x" .. h:sub(2));
end;

local colors               = {
    green   = hex(base_30.green),
    yellow  = hex(base_30.yellow),
    red     = hex(base_30.red),
    blue    = hex(base_30.blue),
    orange  = hex(base_30.orange),
    cyan    = hex(base_30.cyan),
    overlay = hex(base_30.grey_fg),
    base    = normal_bg,
    darker  = float_bg,
};

-- Override Normal background if transparency is enabled
if transparency_enabled then
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" });
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" });
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" });
    vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" });
    vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE" });
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" });
    vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = telescope_border_bg, fg = telescope_border_bg });
end;

vim.api.nvim_set_hl(0, "FloatBorder", { link = "TelescopeBorder" });
vim.api.nvim_set_hl(0, "Tabline", { link = "LineNr" });
vim.api.nvim_set_hl(0, "TablineSel", { link = "Pmenu" });
vim.api.nvim_set_hl(0, "tabline_a_normal", { link = "CursorLineNr" });
vim.api.nvim_set_hl(0, "tabline_b_normal", { link = "LineNr" });
vim.api.nvim_set_hl(0, "tabline_c_normal", { link = "LineNr" });

local ColorSets = {
    -- Floating windows should ALWAYS be solid
    NormalFloat                 = { bg = colors.darker },

    -- LSP Diagnostics
    LspDiagnosticHint           = { fg = colors.green },
    LspDiagnosticWarn           = { fg = colors.orange },
    LspDiagnosticError          = { fg = colors.red },
    LspDiagnosticInfo           = { fg = colors.blue },
    DiagnosticHint              = { fg = colors.green },
    DiagnosticWarn              = { fg = colors.orange },
    DiagnosticError             = { fg = colors.red },
    DiagnosticInfo              = { fg = colors.blue },

    -- Diagnostic open (solid backgrounds)
    DiagnosticOpenSep           = { fg = colors.darker, bg = "NONE" },
    DiagnosticOpenArrow         = { bg = colors.darker, fg = colors.overlay },
    DiagnosticOpenHint          = { fg = colors.green, bg = colors.darker, bold = true },
    DiagnosticOpenWarn          = { fg = colors.yellow, bg = colors.darker, bold = true },
    DiagnosticOpenError         = { fg = colors.red, bg = colors.darker, bold = true },
    DiagnosticOpenInfo          = { fg = colors.blue, bg = colors.darker, bold = true },

    -- Diagnostic lines
    DiagnosticLineHint          = { fg = colors.green, bg = "NONE" },
    DiagnosticLineWarn          = { fg = colors.orange, bg = "NONE" },
    DiagnosticLineError         = { fg = colors.red, bg = "NONE" },
    DiagnosticLineInfo          = { fg = colors.blue, bg = "NONE" },

    -- Virtual text (solid backgrounds)
    DiagnosticVirtualTextHint   = {
        bg     = mergeColors(colors.green, colors.base, 0.1),
        fg     = colors.green,
        bold   = true,
        italic = true,
    },
    DiagnosticVirtualTextWarn   = {
        bg     = mergeColors(colors.orange, colors.base, 0.1),
        fg     = colors.orange,
        bold   = true,
        italic = true,
    },
    DiagnosticVirtualTextError  = {
        bg     = mergeColors(colors.red, colors.base, 0.1),
        fg     = colors.red,
        bold   = true,
        italic = true,
    },
    DiagnosticVirtualTextInfo   = {
        bg     = mergeColors(colors.blue, colors.base, 0.1),
        fg     = colors.blue,
        bold   = true,
        italic = true,
    },
    CursorLine                  = { bg = colors.base },
    CursorLineNr                = { fg = colors.overlay },
    WhiteSpace                  = { fg = lightenColor(colors.base, 1.0) },

    IndentLine                  = { fg = lightenColor(colors.base, 1.0) },
    IndentLineCurrent           = { fg = lightenColor(colors.base, 2.0) },

    -- Symbol usage (solid backgrounds)
    SymbolUsageRounding         = { fg = colors.darker },
    SymbolUsageContent          = { bg = colors.darker, fg = lightenColor(colors.overlay, 0.7), bold = true },
    SymbolUsageRef              = { bg = colors.darker, fg = colors.blue },
    SymbolUsageDef              = { bg = colors.darker, fg = colors.red },
    SymbolUsageImpl             = { bg = colors.darker, fg = colors.yellow },

    -- Underlines (solid backgrounds)
    DiagnosticUnderlineWarn     = { bg = mergeColors(colors.orange, colors.base, 0.2), fg = colors.orange},
    DiagnosticUnderlineHint     = { bg = mergeColors(colors.green, colors.base, 0.2), fg = colors.green },
    DiagnosticUnderlineInfo     = { bg = mergeColors(colors.blue, colors.base, 0.2), fg = colors.blue },
    DiagnosticUnderlineError    = { bg = mergeColors(colors.red, colors.base, 0.2), fg = colors.red },

    TinyDiagnosticVirtualTextWarn  = { bg = mergeColors(colors.orange, colors.base, 0.2), fg = colors.orange},
    TinyDiagnosticVirtualTextHint  = { bg = mergeColors(colors.green, colors.base, 0.2), fg = colors.green },
    TinyDiagnosticVirtualTextInfo  = { bg = mergeColors(colors.blue, colors.base, 0.2), fg = colors.blue },
    TinyDiagnosticVirtualTextError = { bg = mergeColors(colors.red, colors.base, 0.2), fg = colors.red },

    TinyInlineDiagnosticVirtualTextWarn  = { bg = mergeColors(colors.orange, colors.base, 0.2), fg = colors.orange},
    TinyInlineDiagnosticVirtualTextHint  = { bg = mergeColors(colors.green, colors.base, 0.2), fg = colors.green },
    TinyInlineDiagnosticVirtualTextInfo  = { bg = mergeColors(colors.blue, colors.base, 0.2), fg = colors.blue },
    TinyInlineDiagnosticVirtualTextError = { bg = mergeColors(colors.red, colors.base, 0.2), fg = colors.red },

    LspInlayHint                = { bg = nil, fg = lightenColor(colors.base, 2.0) },

    -- TreeSitter context (solid backgrounds)
    TreeSitterContext           = { fg = colors.overlay, bg = colors.darker },
    TreeSitterContextBottom     = { fg = colors.overlay, bg = colors.darker },
    TreeSitterContextLineNumber = { fg = colors.base, bg = colors.darker },
    TreeSitterContextSeparator  = { fg = colors.darker, bg = colors.darker },

    -- Rainbow delimiters
    RainbowDelimiterRed         = { fg = colors.red },
    RainbowDelimiterGreen       = { fg = colors.green },
    RainbowDelimiterBlue        = { fg = colors.blue },
    RainbowDelimiterYellow      = { fg = colors.yellow },
    RainbowDelimiterOrange      = { fg = colors.orange },
    RainbowDelimiterCyan        = { fg = colors.cyan },
    RainbowDelimiterViolet      = { fg = colors.blue },

    -- Git conflict (solid backgrounds)
    GitConflictCurrent          = { bg = mergeColors(colors.yellow, colors.base, 0.1) },
    GitConflictCurrentLabel     = { bg = colors.yellow, fg = colors.base },
    GitConflictIncoming         = { bg = mergeColors(colors.blue, colors.base, 0.1) },
    GitConflictIncomingLabel    = { bg = colors.blue, fg = colors.base },

    -- Render markdown (solid background)
    RenderMarkdownCode          = { bg = colors.darker },
    ScrollbarHandle             = { bg = lightenColor(colors.base, 0.5)},
    ScrollbarGitHandle          = { bg = lightenColor(colors.base, 0.5), fg=colors.cyan},
    ScrollbarHintHandle         = { bg = lightenColor(colors.base, 0.5), fg=colors.green},
    ScrollbarInfoHandle         = { bg = lightenColor(colors.base, 0.5), fg=colors.blue},
    ScrollbarMiscHandle         = { bg = lightenColor(colors.base, 0.5), fg=colors.overlay},
    ScrollbarWarnHandle         = { bg = lightenColor(colors.base, 0.5), fg=colors.orange},
    ScrollbarErrorHandle        = { bg = lightenColor(colors.base, 0.5), fg=colors.red},
    ScrollbarCursorHandle       = { bg = lightenColor(colors.base, 0.5), fg=colors.darker},
    ScrollbarGit                = { fg=colors.cyan},
    ScrollbarHint               = { fg=colors.green},
    ScrollbarInfo               = { fg=colors.blue},
    ScrollbarMisc               = { fg=colors.overlay},
    ScrollbarWarn               = { fg=colors.orange},
    ScrollbarError              = { fg=colors.red},
    ScrollbarCursor             = { fg=colors.darker},
};

for hl, col in pairs(ColorSets) do
    vim.api.nvim_set_hl(0, hl, col);
end;
