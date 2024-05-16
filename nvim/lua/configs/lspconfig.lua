-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig.util"
local servers = { "html", "cssls", "bashls", "marksman" }

-- lsps with default config
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		on_attach = on_attach,
		on_init = on_init,
		capabilities = capabilities,
	}
end

lspconfig.inlay_hints = {
	enabled = true,
}

-- c, cpp
lspconfig.clangd.setup {
	on_attach = function(client, bufnr)
		local lsp_inlayhints = require "lsp-inlayhints"
		lsp_inlayhints.on_attach(client, bufnr)
		lsp_inlayhints.setup {}
		lsp_inlayhints.show()
	end,
	on_init = on_init,
	capabilities = capabilities,
}

-- python
lspconfig.ruff.setup {
	on_attach = function(client, bufnr)
		-- NVM ruff doesn't support inlay hints
		local lsp_inlayhints = require "lsp-inlayhints"
		lsp_inlayhints.on_attach(client, bufnr)
		lsp_inlayhints.setup {}
		lsp_inlayhints.show()
	end,
	on_init = on_init,
	capabilities = capabilities,
	ft = { "python" },
}

-- typescript
lspconfig.tsserver.setup {
	on_attach = function(client, bufnr)
		local lsp_inlayhints = require "lsp-inlayhints"
		lsp_inlayhints.on_attach(client, bufnr)
		lsp_inlayhints.setup {}
		lsp_inlayhints.show()
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
		local lsp_inlayhints = require "lsp-inlayhints"
		lsp_inlayhints.on_attach(client, bufnr)
		lsp_inlayhints.setup {}
		lsp_inlayhints.show()
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
				setType = true,
			},
		},
	},
}

lspconfig.gopls.setup {
	on_attach = function(client, bufnr)
		local lsp_inlayhints = require "lsp-inlayhints"
		lsp_inlayhints.on_attach(client, bufnr)
		lsp_inlayhints.setup {}
		lsp_inlayhints.show()
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
