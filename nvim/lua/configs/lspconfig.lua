-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig.util"
local servers = { "html", "cssls", "clangd" }
local ih = require "inlay-hints"

-- lsps with default config
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		on_attach = on_attach,
		on_init = on_init,
		capabilities = capabilities,
	}
end

-- typescript
lspconfig.tsserver.setup {
	on_attach = function(client, bufnr)
		ih.on_attach(client, bufnr)
		on_attach(client, bufnr)
	end,
	on_init = on_init,
	capabilities = capabilities,
	settings = {
		javascript = {
			inlayHints = {
				interactiveInlayHints = true,
				includeInlayEnumMemberValueHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayVariableTypeHints = true,
			},
		},
		typescript = {
			inlayHints = {
				interactiveInlayHints = true,
				includeInlayEnumMemberValueHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayVariableTypeHints = true,
			},
		},
	},
}

lspconfig.lua_ls.setup {
	on_attach = function(client, bufnr)
		ih.on_attach(client, bufnr)
	end,
	on_init = on_init,
	capabilities = capabilities,
	ft = {
		"lua",
	},
	Settings = {
		Lua = {
			hint = {
				enable = true,
			},
		},
	},
}

lspconfig.gopls.setup {
	on_attach = function(c, b)
		ih.on_attach(c, b)
	end,
	on_init = on_init,
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
				fieldalignment = true,
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},
}

-- lspconfig.rust_analyzer.setup {
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	filetypes = { "rust" },
-- 	root_dir = util.root_pattern "Cargo.toml",
-- 	settings = {
-- 		["rust_analyzer"] = {
-- 			Cargo = {
-- 				allFeatures = true,
-- 			},
-- 		},
-- 	},
-- }
