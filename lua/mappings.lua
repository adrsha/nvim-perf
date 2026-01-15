local map = vim.keymap.set -- for conciseness

map("c", "<C-w>", ":w !sudo tee % > /dev/null<CR>", { desc = "Save file with sudo in command mode" })

-- map("v", "<s-i>", "<Esc>", { desc = "Escape from visual mode" })
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
map("v", "<C-n>", "*<Esc><s-n>", { desc = "Find all instances of selected word" })

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
map("n", "<leader>ff", function() require('oil').open_float() end, { desc = "Find files" })
-- vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

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

map("n", "<leader>cr", function()
    require "nvchad.lsp.renamer"
    -- vim.lsp.buf.rename()
end, { desc = "Rename" })

map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
    vim.cmd("WhichKey " .. vim.fn.input("WhichKey: "))
end, { desc = "whichkey query lookup" })

map({ "n", "t" }, "<A-i>", function()
    require("nvchad.term").toggle({ pos = "float", id = "floatTerm" })
end, { desc = "terminal toggle floating term" })

-- map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
-- map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
-- map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
-- map("n", "gtd", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
-- map("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "Show signature help" })
-- map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
-- map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
-- map("n", "gr", vim.lsp.buf.references, { desc = "Show references" })
map('n', 'gd', '<CMD>Glance definitions<CR>')
map('n', 'gr', '<CMD>Glance references<CR>')
map('n', 'gD', '<CMD>Glance type_definitions<CR>')
map('n', 'gi', '<CMD>Glance implementations<CR>')

map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "List workspace folders" })

map("n", "<leader>re", function()
    vim.cmd.RustLsp({ 'explainError', 'current' })
end, { desc = "Rust Explain error" })

map("n", "<leader>rj", function()
    vim.cmd.RustLsp('joinLines')
end, { desc = "Rust Join Lines" })

map("n", "<leader>rrd", function()
    vim.cmd.RustLsp('relatedDiagnostics')
end, { desc = "Rust related diagnostics" })

vim.keymap.set("n", "<leader>tih", function()
    vim.lsp.inlay_hint.enable(
        not vim.lsp.inlay_hint.is_enabled()
    )
end, { desc = "Toggle todo in telescope" })

map('n', '<leader>td', function()
    local builtin = require("telescope.builtin")
    local themes  = require("telescope.themes")

    builtin.diagnostics(themes.get_ivy())
end)
map('n', '<leader>tt', '<CMD>TodoTelescope<CR>')
-- map('n', 'gco', '<Plug>(git-conflict-ours)')
-- map('n', 'gct', '<Plug>(git-conflict-theirs)')
-- map('n', 'gcb', '<Plug>(git-conflict-both)')
-- map('n', 'gc0', '<Plug>(git-conflict-none)')
-- map('n', 'gcn', '<Plug>(git-conflict-prev-conflict)')
-- map('n', 'gcp', '<Plug>(git-conflict-next-conflict)')

map('n', '<leader>j', function() require('mini.splitjoin').toggle() end)

map('n', 'g<space>', function()
    require("gitsigns").preview_hunk_inline()
end, { desc = "Git Show hunk" })


map("n", "<S-l>", ":noh<CR>", { desc = "Reset searches" })
map("n", "<S-k>", function()
    require("pretty_hover").hover()
end, { desc = "Reset searches" })

map("n", "<C-k>", function()
    require('treewalker').move_up()
end, { desc = "Treesitter motion Up" })
map("n", "<C-j>", function()
    require('treewalker').move_down()
end, { desc = "Treesitter motion Down" })
map("n", "<C-l>", function()
    require('treewalker').move_in()
end, { desc = "Treesitter motion Right" })
map("n", "<C-h>", function()
    require('treewalker').move_out()
end, { desc = "Treesitter motion Left" })
map("n", "<C-A-j>", function()
    require('treewalker').swap_down()
end, { desc = "Treesitter motion Down" })
map("n", "<C-A-k>", function()
    require('treewalker').swap_up()
end, { desc = "Treesitter motion Up" })
map("n", "<C-A-l>", function()
    require('treewalker').swap_in()
end, { desc = "Treesitter motion Right" })
map("n", "<C-A-h>", function()
    require('treewalker').swap_out()
end, { desc = "Treesitter motion Left" })
-- map("n", "<S-l>", function ()
--
-- end, { desc = "Reset searches" })
