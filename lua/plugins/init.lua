return {
	"nvim-lua/plenary.nvim",

	"nvchad/volt",
	{
		"nvchad/minty",
		cmd = { "Shades", "Huefy" },
		opts = { huefy = { border = false } },
	},

	{
		"nvim-tree/nvim-web-devicons",
	},

	{
		"nvchad/ui",
		event = "User FilePost",
		lazy = false,
		config = function()
			require("nvchad")
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		-- event = "User FilePost",
		main = "ibl",
		opts = {
			indent = { char = "│", highlight = "Whitespace" },
			scope = { char = "│", highlight = "Added" },
		},
	},

	{
		"folke/which-key.nvim",
		keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
		cmd = "WhichKey",
	},

	{
		"nvchad/base46",
		build = function()
			require("base46").load_all_highlights()
		end,
	},
}
