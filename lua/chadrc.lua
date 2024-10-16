local configs = require("lsp_config")

local servers = {
	html = {},
	cssls = {},
	awk_ls = {},
	bashls = {},
	rust_analyzer = {},

	pyright = {
		settings = {
			python = {
				analysis = {
					autoSearchPaths = true,
					typeCheckingMode = "basic",
				},
			},
		},
	},
}

for name, opts in pairs(servers) do
	opts.on_init = configs.on_init
	opts.on_attach = configs.on_attach
	opts.capabilities = configs.capabilities

	require("lspconfig")[name].setup(opts)
end

local options = {

	base46 = {
		theme = "everblush", -- default theme
		hl_add = {},
		hl_override = {},
		integrations = {},
		changed_themes = {},
		transparency = false,
		theme_toggle = { "onedark", "one_light" },
	},

	ui = {
		cmp = {
			icons_left = true, -- only for non-atom styles!
			lspkind_text = true,
			style = "flat_dark", -- default/flat_light/flat_dark/atom/atom_colored
			format_colors = {
				tailwind = true, -- will work for css lsp too
				icon = "󱓻",
			},
		},
		telescope = { style = "borderless" }, -- borderless / bordered
		-- lazyload it when there are 1+ buffers
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
		enabled = false,
		mode = "virtual", -- fg, bg, virtual
		virt_text = "󱓻 ",
		highlight = { hex = true, lspvars = true },
	},
}

local status, chadrc = pcall(require, "chadrc")
return vim.tbl_deep_extend("force", options, status and chadrc or {})
