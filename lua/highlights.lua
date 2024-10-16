-- Utility function to convert hex string to number
local function hexToNum(hex)
	return tonumber(hex:sub(2), 16)
end

-- Utility function to ensure color is in numeric format
local function ensureColorNum(color)
	if type(color) == "string" and color:sub(1, 1) == "#" then
		return hexToNum(color)
	end
	return color
end

local function mergeColors(color1, color2, weight)
	weight = weight or 0.5 -- default to 50% merge
	color1 = ensureColorNum(color1)
	color2 = ensureColorNum(color2)

	-- Extract RGB components
	local r1 = math.floor(color1 / 0x10000)
	local g1 = math.floor((color1 % 0x10000) / 0x100)
	local b1 = color1 % 0x100

	local r2 = math.floor(color2 / 0x10000)
	local g2 = math.floor((color2 % 0x10000) / 0x100)
	local b2 = color2 % 0x100

	-- Merge components
	local r = math.floor(r1 * weight + r2 * (1 - weight))
	local g = math.floor(g1 * weight + g2 * (1 - weight))
	local b = math.floor(b1 * weight + b2 * (1 - weight))

	-- Combine components back into a hex color
	return string.format("#%02X%02X%02X", r, g, b)
end

local function darkenColor(color, amount)
	amount = amount or 0.1 -- default darkening amount

	-- Convert hex string to number if necessary
	if type(color) == "string" and color:sub(1, 1) == "#" then
		color = tonumber(color:sub(2), 16)
	end

	-- Extract RGB components
	local r = math.floor(color / 0x10000)
	local g = math.floor((color % 0x10000) / 0x100)
	local b = color % 0x100

	-- Darken each component
	r = math.max(math.floor(r * (1 - amount)), 0)
	g = math.max(math.floor(g * (1 - amount)), 0)
	b = math.max(math.floor(b * (1 - amount)), 0)

	-- Combine components back into a hex color
	return string.format("#%02X%02X%02X", r, g, b)
end

local colors = {
	green = vim.api.nvim_get_hl(0, { name = "Added" }).fg,
	yellow = vim.api.nvim_get_hl(0, { name = "CurSearch" }).bg,
	red = vim.api.nvim_get_hl(0, { name = "Removed" }).fg,
	blue = vim.api.nvim_get_hl(0, { name = "DevIconLua" }).fg,
	orange = vim.api.nvim_get_hl(0, { name = "IncSearch" }).bg,
	cyan = vim.api.nvim_get_hl(0, { name = "Special" }).fg,
	overlay = vim.api.nvim_get_hl(0, { name = "LineNr" }).fg,
	base = vim.api.nvim_get_hl(0, { name = "ErrorMsg" }).bg,
	darker = vim.api.nvim_get_hl(0, { name = "TelescopeBorder" }).bg,
}

vim.api.nvim_set_hl(0, "FloatBorder", { link = "TelescopeBorder" })
vim.api.nvim_set_hl(0, "Tabline", { link = "LineNr" })
vim.api.nvim_set_hl(0, "TablineSel", { link = "Pmenu" })
vim.api.nvim_set_hl(0, "tabline_a_normal", { link = "CursorLineNr" })
vim.api.nvim_set_hl(0, "tabline_b_normal", { link = "LineNr" })
vim.api.nvim_set_hl(0, "tabline_c_normal", { link = "LineNr" })

local TelescopeColor = {
	LspDiagnosticHint = { fg = colors.green },
	LspDiagnosticWarn = { fg = colors.orange },
	LspDiagnosticError = { fg = colors.red },
	LspDiagnosticInfo = { fg = colors.blue },
	DiagnosticHint = { fg = colors.green },
	DiagnosticWarn = { fg = colors.orange },
	DiagnosticError = { fg = colors.red },
	DiagnosticInfo = { fg = colors.blue },
	DiagnosticOpenSep = { fg = colors.darker, bg = NONE },
	DiagnosticOpenArrow = { bg = colors.darker, fg = colors.overlay },
	DiagnosticOpenHint = { fg = colors.green, bg = colors.darker, bold = true },
	DiagnosticOpenWarn = { fg = colors.yellow, bg = colors.darker, bold = true },
	DiagnosticOpenError = { fg = colors.red, bg = colors.darker, bold = true },
	DiagnosticOpenInfo = { fg = colors.blue, bg = colors.darker, bold = true },
	DiagnosticLineHint = { fg = colors.green, bg = NONE },
	DiagnosticLineWarn = { fg = colors.orange, bg = NONE },
	DiagnosticLineError = { fg = colors.red, bg = NONE },
	DiagnosticLineInfo = { fg = colors.blue, bg = NONE },
	DiagnosticVirtualTextHint = {
		bg = mergeColors(colors.green, colors.base, 0.1),
		fg = colors.green,
		bold = true,
		italic = true,
	},
	DiagnosticVirtualTextWarn = {
		bg = mergeColors(colors.yellow, colors.base, 0.1),
		fg = colors.yellow,
		bold = true,
		italic = true,
	},
	DiagnosticVirtualTextError = {
		bg = mergeColors(colors.red, colors.base, 0.1),
		fg = colors.red,
		bold = true,
		italic = true,
	},
	DiagnosticVirtualTextInfo = {
		bg = mergeColors(colors.blue, colors.base, 0.1),
		fg = colors.blue,
		bold = true,
		italic = true,
	},
	-- DiagnosticUnderlineHint = { fg = colors.green },
	-- DiagnosticUnderlineWarn = { fg = colors.yellow },
	-- DiagnosticUnderlineError = { fg = colors.red },
	-- DiagnosticUnderlineInfo = { fg = colors.blue },
	DiagnosticUnderlineHint = { bg = mergeColors(colors.green, colors.base, 0.2), fg = colors.green },
	DiagnosticUnderlineWarn = { bg = mergeColors(colors.yellow, colors.base, 0.2), fg = colors.yellow },
	DiagnosticUnderlineError = { bg = mergeColors(colors.red, colors.base, 0.2), fg = colors.red },
	DiagnosticUnderlineInfo = { bg = mergeColors(colors.blue, colors.base, 0.2), fg = colors.blue },
	TreeSitterContext = { fg = colors.overlay0, bg = colors.base },
	TreeSitterContextSeparator = { fg = colors.green, bg = colors.base },
	RainbowDelimiterRed = { fg = colors.red },
	RainbowDelimiterGreen = { fg = colors.green },
	RainbowDelimiterBlue = { fg = colors.blue },
	RainbowDelimiterYellow = { fg = colors.yellow },
	RainbowDelimiterOrange = { fg = colors.orange },
	RainbowDelimiterCyan = { fg = colors.cyan },
	RainbowDelimiterViolet = { fg = colors.blue },
}

for hl, col in pairs(TelescopeColor) do
	vim.api.nvim_set_hl(0, hl, col)
end
