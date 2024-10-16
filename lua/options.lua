local opt = vim.opt
local g = vim.g

opt.hidden = true
opt.pumheight = 18
opt.cmdheight = 0
opt.splitbelow = true
opt.splitright = true

opt.list = false
opt.termguicolors = true
opt.conceallevel = 2
opt.showtabline = 0

opt.showmode = false
opt.backup = false
opt.writebackup = false
opt.number = true

opt.ruler = false
opt.updatetime = 250
opt.timeoutlen = 500
opt.clipboard = "unnamedplus"
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.scrolloff = 0
opt.mouse = "a"
opt.cursorline = false

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 0
-- opt.autoindent = false
opt.smartindent = true

opt.wrap = false
opt.expandtab = true
opt.laststatus = 0
opt.fillchars = { eob = "⠀" }

opt.undofile = true
opt.swapfile = false

opt.shortmess:append("sIcaWFSA")

opt.signcolumn = "yes"
opt.numberwidth = 3
opt.whichwrap:append("<,>,[,],h,l")

opt.formatoptions:remove({ "c", "r", "o" }) -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has("win32") ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath("data"), "mason", "bin" }, sep) .. delim .. vim.env.PATH
