return {
	"Exafunction/codeium.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
	event = "BufEnter",
	config = function()
		require("codeium").setup({
			workspace_root = {
				use_lsp = true,
				find_root = nil,
				paths = {
					".bzr",
					".git",
					".hg",
					".svn",
					"_FOSSIL_",
					"package.json",
				},
			},
		})
	end,
}
