return {
  "nvim-treesitter/nvim-treesitter",

  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-context",
      event = "VeryLazy",
      dependency = {
        "nvim-treesitter/nvim-treesitter",
      },
    },
    {
      'MeanderingProgrammer/render-markdown.nvim',
      -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
      -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
      opts = {},
    },

    {
      "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
      -- event = "VeryLazy",
      dependency = {
        "nvim-treesitter/nvim-treesitter",
      },
    },
  },

  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
  opts = function()
    pcall(function()
      dofile(vim.g.base46_cache .. "syntax")
      dofile(vim.g.base46_cache .. "treesitter")
    end)

    return {
      ensure_installed = { "lua", "luadoc", "printf", "vim", "vimdoc", "markdown", "regex", "diff"},

      highlight = {
        enable = true,
        use_languagetree = true,
      },

      indent = { enable = true },
    }
  end,
  config = function(_, opts)
    require("treesitter-context").setup({
      enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
      max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = "outer",     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = "topline",         -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = "━",
      zindex = 21,     -- The Z-index of the context window
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    })

    local rainbow_delimiters = require("rainbow-delimiters")

    vim.g.rainbow_delimiters = {
      strategy = {
        [""] = rainbow_delimiters.strategy["global"],
      },
      query = {
        [""] = "rainbow-delimiters",
      },
      priority = {
        [""] = 110,
      },
      highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
      },
      blacklist = { "html" },
    }

    require("nvim-treesitter.configs").setup(opts)
  end,
}
