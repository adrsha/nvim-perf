return {
	defaults = { lazy = true },
	install = { colorscheme = { "nvchad" } },

	checker = {
		-- automatically check for plugin updates
		enabled = false,
		concurrency = nil, ---@type number? set to 1 to check for updates very slowly
		notify = true, -- get a notification when new updates are found
		frequency = 3600, -- check for updates every hour
		check_pinned = false, -- check for pinned packages that can't be updated
	},

	change_detection = {
		-- automatically check for config file changes and reload the ui
		enabled = false,
		notify = false, -- get a notification when changes are found
	},

	ui = {
		icons = {
			ft = "",
			lazy = "󰂠 ",
			loaded = "",
			not_loaded = "",
		},
	},

	performance = {
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"archlinux", -- Added
				"bugreport",
				"compiler",
				"ftplugin",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"matchit",
				"matchparen",
				"netrw",
				"netrwFileHandlers",
				"netrwPlugin",
				"netrwSettings",
				"optwin",
				"rplugin",
				"rrhelper",
				"spellfile_plugin",
				"sleuth", -- Added
				"synmenu",
				"syntax",
				"tar",
				"tarPlugin",
				"tohtml",
				"tutor",
				"tutor_mode_plugin", -- Added
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
			},
		},
	},
}
