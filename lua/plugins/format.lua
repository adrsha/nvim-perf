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
        -- format_on_save = {
        --     timeout_ms = 500,
        --     lsp_fallback = true,
        -- },
        -- Configure formatters to preserve end of line
        formatters = {
            stylua = {
                prepend_args = { "--indent-type", "Spaces", "--quote-style", "AutoPreferDouble", "--maintain-line-endings" }
            },
            prettierd = {
                prepend_args = { "--end-of-line", "lf", "--print-width", "100" }
            },
            -- Add specific options for other formatters as needed
        }
    },
}
