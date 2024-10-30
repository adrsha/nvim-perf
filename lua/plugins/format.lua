return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      css = { "prettierd" },
      html = { "prettierd" },
      kotlin = { "ktlint" },
      cpp = { "cpplint" },
    },

    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
