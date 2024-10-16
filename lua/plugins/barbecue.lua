return {
	"utilyre/barbecue.nvim",
	name = "barbecue",
	version = "*",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons", -- optional dependency
	},
	config = function()
		local hl = vim.api.nvim_get_hl(0, { name = "LineNr" })
		local hl_b = vim.api.nvim_get_hl(0, { name = "LineNr" })
		require("barbecue").setup({
			show_dirname = false,
			show_basename = false,
			show_modified = true, -- configurations go here

			theme = {
				-- this highlight is used to override other highlights
				-- you can take advantage of its `bg` and set a background throughout your winbar
				-- (e.g. basename will look like this: { fg = "#c0caf5", bold = true })
				normal = {},

				-- these highlights correspond to symbols table from config
				ellipsis = { fg = hl.fg },
				separator = { fg = hl.fg },
				modified = { fg = hl.fg },

				-- these highlights represent the _text_ of three main parts of barbecue
				dirname = { fg = hl.fg },
				basename = { bold = true },
				context = { bold = true },

				-- these highlights are used for context/navic icons
				context_file = { fg = hl_b.fg },
				context_module = { fg = hl_b.fg },
				context_namespace = { fg = hl_b.fg },
				context_package = { fg = hl_b.fg },
				context_class = { fg = hl_b.fg },
				context_method = { fg = hl_b.fg },
				context_property = { fg = hl_b.fg },
				context_field = { fg = hl_b.fg },
				context_constructor = { fg = hl_b.fg },
				context_enum = { fg = hl_b.fg },
				context_interface = { fg = hl_b.fg },
				context_function = { fg = hl_b.fg },
				context_variable = { fg = hl_b.fg },
				context_constant = { fg = hl_b.fg },
				context_string = { fg = hl_b.fg },
				context_number = { fg = hl_b.fg },
				context_boolean = { fg = hl_b.fg },
				context_array = { fg = hl_b.fg },
				context_object = { fg = hl_b.fg },
				context_key = { fg = hl_b.fg },
				context_null = { fg = hl_b.fg },
				context_enum_member = { fg = hl_b.fg },
				context_struct = { fg = hl_b.fg },
				context_event = { fg = hl_b.fg },

				context_operator = { fg = hl_b.fg },
				context_type_parameter = { fg = hl_b.fg },
			},
		})
	end,
}
