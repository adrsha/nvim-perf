-- Create a namespace for line diagnostics virtual text
local line_diagnostics_ns = vim.api.nvim_create_namespace("line_diagnostics")
-- Flag to track whether diagnostics are currently shown
local diagnostics_visible = false
-- Variable to store the line number where diagnostics are shown
local diagnostic_line_nr = nil
-- Store extmark IDs
local extmark_ids = {}

-- Function to toggle diagnostics on the current line
local function toggle_line_diagnostics()
	local bufnr = vim.api.nvim_get_current_buf()
	local line_nr = vim.api.nvim_win_get_cursor(0)[1] - 1 -- Get current line number

	-- If diagnostics are already visible on the same line, clear them
	if diagnostics_visible and diagnostic_line_nr == line_nr then
		-- Clear virtual text
		vim.api.nvim_buf_clear_namespace(bufnr, line_diagnostics_ns, 0, -1)
		for _, id in ipairs(extmark_ids) do
			vim.api.nvim_buf_del_extmark(bufnr, line_diagnostics_ns, id)
		end
		diagnostics_visible = false
		diagnostic_line_nr = nil
		extmark_ids = {}
		return
	end

	-- Otherwise, clear any previous diagnostics and show diagnostics for the current line
	if diagnostics_visible then
		vim.api.nvim_buf_clear_namespace(bufnr, line_diagnostics_ns, 0, -1)
		for _, id in ipairs(extmark_ids) do
			vim.api.nvim_buf_del_extmark(bufnr, line_diagnostics_ns, id)
		end
		extmark_ids = {}
	end

	-- Get diagnostics for the current line
	local diagnostics = vim.diagnostic.get(bufnr, { lnum = line_nr })

	-- Return if no diagnostics are available on this line
	if #diagnostics == 0 then
		return
	end

	-- Get the indent of the current line
	local current_line = vim.api.nvim_buf_get_lines(bufnr, line_nr, line_nr + 1, false)[1]
	local indent = current_line:match("^%s*")

	-- Define a table to map diagnostic severities to highlight groups and icons
	local severity_to_hl = {
		[vim.diagnostic.severity.ERROR] = { hl = "DiagnosticOpenError", icon = "󰅙  " },
		[vim.diagnostic.severity.WARN] = { hl = "DiagnosticOpenWarn", icon = "  " },
		[vim.diagnostic.severity.INFO] = { hl = "DiagnosticOpenInfo", icon = "󰋼  " },
		[vim.diagnostic.severity.HINT] = { hl = "DiagnosticOpenHint", icon = "󰌵  " },
	}

	-- Create a table to hold all virtual lines
	local all_virtual_lines = {}

	-- Set virtual lines for each diagnostic
	for i, diagnostic in ipairs(diagnostics) do
		local virtual_text = {
			{ indent },
			{ " ", "DiagnosticOpenSep" }, -- 󰮷
			{ i == 1 and " 󰦺 " or " : ", "DiagnosticOpenArrow" },
			{ " ", "DiagnosticOpenSep" },
		}

		-- Get the appropriate highlight group and icon for the diagnostic severity
		local severity = severity_to_hl[diagnostic.severity] or { hl = "DiagnosticVirtualText", icon = "" }

		-- Add the diagnostic message with the correct icon and highlight group
		table.insert(virtual_text, { " " .. severity.icon .. diagnostic.message .. " ", severity.hl })
		table.insert(virtual_text, { " ", "DiagnosticOpenSep" })

		-- Add this virtual_text to our all_virtual_lines table
		table.insert(all_virtual_lines, virtual_text)
	end

	-- Set all virtual lines in a single extmark
	local id = vim.api.nvim_buf_set_extmark(bufnr, line_diagnostics_ns, line_nr, 0, {
		virt_lines = all_virtual_lines,
		virt_lines_above = false,
		hl_mode = "combine",
	})
	table.insert(extmark_ids, id)

	diagnostics_visible = true
	diagnostic_line_nr = line_nr
end

-- Autocommand to clear diagnostics when the cursor moves
vim.api.nvim_create_autocmd("CursorMoved", {
	callback = function()
		-- Clear diagnostics if moving to a different line
		if diagnostic_line_nr and diagnostic_line_nr ~= vim.api.nvim_win_get_cursor(0)[1] - 1 then
			local bufnr = vim.api.nvim_get_current_buf()
			vim.api.nvim_buf_clear_namespace(bufnr, line_diagnostics_ns, 0, -1)
			for _, id in ipairs(extmark_ids) do
				vim.api.nvim_buf_del_extmark(bufnr, line_diagnostics_ns, id)
			end
			diagnostics_visible = false
			diagnostic_line_nr = nil
			extmark_ids = {}
		end
	end,
})

--
--
--   MAPPINGS
--
--
--

local opts = { noremap = true, silent = true }
local map = vim.keymap.set -- for conciseness
vim.g.mapleader = " "
vim.g.maplocalleader = ";"

map("c", "<C-w>", ":w !sudo tee % > /dev/null<CR>", { desc = "Save file with sudo in command mode" })

-- map("n", "o", "o<Esc>^Da", { desc = "Next line without commenting" })
-- map("n", "O", "O<Esc>^Da", { desc = "Next line without commenting" })

map("n", "<C-Up>", ":resize -2<CR>", { desc = "Resize window vertically (-2)" })
map("n", "<C-Down>", ":resize +2<CR>", { desc = "Resize window vertically (+2)" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize window horizontally (-2)" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize window horizontally (+2)" })

map("n", "<A-Up>", "<C-\\><C-N><C-w>k", { desc = "Switch to window above" })
map("n", "<A-Right>", "<C-\\><C-N><C-w>l", { desc = "Switch to window to the right" })
map("n", "<A-Left>", "<C-\\><C-N><C-w>h", { desc = "Switch to window to the left" })
map("n", "<A-Down>", "<C-\\><C-N><C-w>j", { desc = "Switch to window below" })

map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move current line down in insert mode" })
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move current line up in insert mode" })
map("x", "<A-j>", ":m '>+1<CR>gv-gv", { desc = "Move selected lines down" })
map("x", "<A-k>", ":m '<-2<CR>gv-gv", { desc = "Move selected lines up" })
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move current line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move current line up" })

map("n", "<C-n>", "*", { desc = "Find all instances of word under cursor" })
map("v", "<C-n>", "*", { desc = "Find all instances of selected word" })

map("n", "<C-y>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

map("v", "<", "<gv", { desc = "Indent left without unselecting in visual mode" })
map("v", ">", ">gv", { desc = "Indent right without unselecting in visual mode" })
map("n", "<", "<<", { desc = "Indent line left in normal mode" })
map("n", ">", ">>", { desc = "Indent line right in normal mode" })

map("n", "<leader>bd", "<CMD>bdelete<CR>", { desc = "Close current buffer" })

map("n", "<C-s>", ":%s/", { desc = "Search and replace" })
map("i", "<C-s>", "<Esc>:%s/", { desc = "Search and replace in insert mode" })

map("n", "<Tab>", "<CMD>bnext<CR>", { desc = "Go to next buffer" })
map("n", "<S-Tab>", "<CMD>bprev<CR>", { desc = "Go to previous buffer" })

map("n", "<leader><leader>", "<CMD>Telescope<CR>", { desc = "Open Telescope main menu" })
map("n", "<leader>fr", "<CMD>Telescope oldfiles<CR>", { desc = "Find recent files" })
-- map("n", "<leader>ff", "<CMD>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>ff", "<CMD>Oil --float<CR>", { desc = "Find files" })

map(
	"n",
	"<leader>fa",
	"<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
	{ desc = "telescope find all files" }
)
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>lg", "<CMD>Telescope live_grep<CR>", { desc = "Live grep with Telescope" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>st", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })

-- map("n", "gd", "<CMD>Telescope lsp_definitions<CR>", { desc = "Go to definition (LSP)" })
-- map("n", "gr", "<CMD>Telescope lsp_references<CR>", { desc = "Find references (LSP)" })
-- map("n", "gt", "<CMD>Telescope lsp_type_definitions<CR>", { desc = "Go to type definition (LSP)" })
-- map("n", "gi", "<CMD>Telescope lsp_implementations<CR>", { desc = "Go to implementation (LSP)" })

map("n", "<leader>ca", function()
	require("tiny-code-action").code_action()
end, { noremap = true, silent = true, desc = "Code Actions(LSP)" })

map("n", "<leader>cF", function()
	require("conform").format({ lsp_fallback = true })
end, { desc = "general format file" })

map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
	vim.cmd("WhichKey " .. vim.fn.input("WhichKey: "))
end, { desc = "whichkey query lookup" })

map({ "n", "t" }, "<A-i>", function()
	require("nvchad.term").toggle({ pos = "float", id = "floatTerm" })
end, { desc = "terminal toggle floating term" })

map("n", "<leader>cc", function()
	require("minty.huefy").open()
end, { desc = "Color Picker" })

map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "gtd", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
map("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "Show signature help" })
map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })

map("n", "<leader>wl", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "List workspace folders" })

map("n", "<leader>rr", function()
	vim.lsp.buf.rename()
end, { desc = "Rename" })

-- map("n", "<leader>rr", require("nvchad.lsp.renamer"), {desc = "NvRenamer"})

map("n", "gr", vim.lsp.buf.references, { desc = "Show references" })
map("n", "L", toggle_line_diagnostics, { desc = "Show references" })
