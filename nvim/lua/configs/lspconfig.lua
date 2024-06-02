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
	on_attach = function(_, bufnr)
		vim.lsp.inlay_hint.enable(true, { bufnr })
	end,
	on_init = on_init,
	capabilities = capabilities,
	settings = {
		clangd = {
			InlayHints = {
				Designators = true,
				Enabled = true,
				ParameterNames = true,
				DeducedTypes = true,
				-- BlockEnd = true, -- only in clangd v17+
			},
		},
	},
}

-- python
lspconfig.ruff.setup {
	on_attach = on_attach,
	on_init = on_init,
	capabilities = capabilities,
	ft = { "python" },
}

-- lspconfig.pylyzer.setup {
-- 	on_attach = function(_, bufnr)
-- 		vim.lsp.inlay_hint.enable(true, { bufnr })
-- 	end,
-- 	on_init = on_init,
-- 	capabilities = capabilities,
-- 	ft = { "python" },
-- 	settings = {
-- 		python = {
-- 			checkOnType = false,
-- 			diagnostics = false,
-- 			inlayHints = true,
-- 			smartCompletion = true,
-- 		},
-- 	},
-- }

-- typescript
lspconfig.tsserver.setup {
	on_attach = function(_, bufnr)
		vim.lsp.inlay_hint.enable(true, { bufnr })
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
	-- init_options = {
	-- 	plugins = {
	-- 		{
	-- 			name = "@vue/typescript-plugin",
	-- 			languages = { "vue" },
	-- 		},
	-- 	},
	-- },
	ft = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
}

lspconfig.volar.setup {
	on_attach = on_attach,
	on_init = on_init,
	capabilities = capabilities,
	ft = { "vue" },
}

lspconfig.lua_ls.setup {
	on_attach = function(client, bufnr)
		vim.lsp.inlay_hint.enable(true, { bufnr })
		local path = client.workspace_folders[1].name
		if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
			return
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					-- Depending on the usage, you might want to add additional paths here.
					-- "${3rd}/luv/library"
					-- "${3rd}/busted/library",
				},
				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
				-- library = vim.api.nvim_get_runtime_file("", true)
			},
		})
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
				arrayIndex = "Enable",
				paramName = "All",
				semicolon = "All",
			},
			completion = {
				workspaceWord = true,
				callSnippet = "Both",
			},
			misc = {
				parameters = {
					"--log-level=trace",
				},
			},
			diagnostics = {
				disable = { "incomplete-signature-doc" },
				-- enable = false,
				groupSeverity = {
					strong = "Warning",
					strict = "Warning",
				},
				groupFileStatus = {
					["ambiguity"] = "Opened",
					["await"] = "Opened",
					["codestyle"] = "None",
					["duplicate"] = "Opened",
					["global"] = "Opened",
					["luadoc"] = "Opened",
					["redefined"] = "Opened",
					["strict"] = "Opened",
					["strong"] = "Opened",
					["type-check"] = "Opened",
					["unbalanced"] = "Opened",
					["unused"] = "Opened",
				},
				unusedLocalExclude = { "_*" },
			},
			workspace = {
				checkThirdParty = false,
			},
		},
	},
}

lspconfig.gopls.setup {
	on_attach = function(_, bufnr)
		vim.lsp.inlay_hint.enable(true, { bufnr })
		require("neodev").setup()
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
