local M = {}
local map = vim.keymap.set

-- export on_attach & capabilities
M.on_attach = function(_, bufnr)
    local function opts(desc)
        return { buffer = bufnr, desc = "LSP " .. desc }
    end
end

-- disable semanticTokens
M.on_init = function(client, _)
    if client.supports_method("textDocument/semanticTokens") then
        client.server_capabilities.semanticTokensProvider = nil
    end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    },
}

M.defaults = function()
    dofile(vim.g.base46_cache .. "lsp")
    local x = vim.diagnostic.severity

    local signs = {
        Error = "󰅙",
        Warn = "",
        Hint = "󰌵",
        Info = "󰋼",
    }

    vim.diagnostic.config({
        virtual_text = {
            prefix = function(diagnostic)
                if diagnostic.severity == vim.diagnostic.severity.ERROR then
                    return " " .. signs["Error"] .. "  "
                elseif diagnostic.severity == vim.diagnostic.severity.WARN then
                    return " " .. signs["Warn"] .. "  "
                elseif diagnostic.severity == vim.diagnostic.severity.INFO then
                    return " " .. signs["Hint"] .. " "
                else
                    return " " .. signs["Info"] .. " "
                end
            end,
        },
        signs = {
            text = {
                [x.ERROR] = signs["Error"],
                [x.WARN] = signs["Warn"],
                [x.INFO] = signs["Info"],
                [x.HINT] = signs["Hint"],
            },
        },
        severity_sort = true, -- Sort by severity (errors first)
        underline = true,
        float = { border = "shadow" },
    })

    require("lspconfig").lua_ls.setup({
        on_attach = M.on_attach,
        capabilities = M.capabilities,
        on_init = M.on_init,

        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    library = {
                        vim.fn.expand("$VIMRUNTIME/lua"),
                        vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                        vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
                        vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
                        "${3rd}/luv/library",
                    },
                    maxPreload = 100000,
                    preloadFileSize = 10000,
                },
            },
        },
    })
end

return M
