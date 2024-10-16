local options = {

	{
		name = "󱠦  Lsp Actions",
		hl = "Exblue",
		items = "lsp",
	},

	{ name = "separator" },

	{
		name = "  Open in terminal",
		hl = "ExRed",
		cmd = function()
			local old_buf = require("menu.state").old_data.buf
			local old_bufname = vim.api.nvim_buf_get_name(old_buf)
			local old_buf_dir = vim.fn.fnamemodify(old_bufname, ":h")

			local cmd = "cd " .. old_buf_dir

			-- base46_cache var is an indicator of nvui user!
			if vim.g.base46_cache then
				require("nvchad.term").new({ cmd = cmd, pos = "sp" })
			else
				vim.cmd("enew")
				vim.fn.termopen({ vim.o.shell, "-c", cmd .. " ; " .. vim.o.shell })
			end
		end,
	},

	{ name = "separator" },

	{
		name = "  Color Picker",
		cmd = function()
			require("minty.huefy").open()
		end,
	},
}
vim.keymap.set("n", "<RightMouse>", function()
	vim.cmd.exec('"normal! \\<RightMouse>"')

	require("menu").open(options, { mouse = true })
end, {})

return {
	{
		"nvchad/menu",
		lazy = true,
		dependencies = {
			{ "nvchad/volt", lazy = true },
		},
		config = function() end,
	},
}
