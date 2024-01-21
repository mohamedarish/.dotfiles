local base = require "plugins.configs.lspconfig"
local on_attach = base.on_attach
local capabilities = base.capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

-- local servers = {
--   "tsserver",
--   "lua_ls",
--   "eslint",
--   "cssls",
--   "rust_analyzer"
-- }
--
-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup({
--     on_attach = on_attach,
--     capabilities = capabilities
--   })
-- end

lspconfig.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    ft = {
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
    },
}

lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    ft = {
        "lua",
    },
}

lspconfig.eslint.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    ft = {
        "html",
        "css",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
    },
}

lspconfig.cssls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    ft = {
        "css",
        "sass",
        "scss",
    },
}

lspconfig.rust_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    ft = {
        "rust",
    },
    root_dir = util.root_pattern "Cargo.toml",
    settings = {
        ["rust-analyzer"] = {
            diagnostics = {
                enable = true,
            },
            cargo = {
                allFeatures = true,
            },
        },
    },
}

lspconfig.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    ft = { "python" },
}

lspconfig.clangd.setup {
    on_attach = function(client, bufnr)
        client.server_capabilities.signatureHelpProvider = false
        on_attach(client, bufnr)
    end,
    capabilities = capabilities,
    filetypes = { "C", "C++" },
}

lspconfig.marksman.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "markdown" },
}

lspconfig.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
            },
        },
    },
}
