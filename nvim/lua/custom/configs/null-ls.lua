local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require "null-ls"

local opts = {
    sources = {
        -- python
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.diagnostics.ruff,

        -- c and cpp
        null_ls.builtins.formatting.clang_format,

        -- lua
        null_ls.builtins.diagnostics.luacheck,
        null_ls.builtins.formatting.stylua,

        -- markdown
        null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.formatting.markdownlint,

        -- yaml
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.formatting.yamlfmt,

        -- json
        null_ls.builtins.diagnostics.jsonlint,
        null_ls.builtins.formatting.fixjson,

        -- go
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.goimports_reviser,
        null_ls.builtins.formatting.golines,
    },
    on_attach = function(client, bufnr)
        if client.supports_method "textDocument/formatting" then
            vim.api.nvim_clear_autocmds {
                group = augroup,
                buffer = bufnr,
            }
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format {
                        bufnr = bufnr,
                    }
                end,
            })
        end
    end,
}

return opts
