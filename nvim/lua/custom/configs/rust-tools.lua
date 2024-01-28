local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local options = {
	server = {
		on_attach = function(client, bufnr)
			require("rust-tools").inlay_hints.enable()
			on_attach(client, bufnr)
		end,
		capabilities = capabilities,
		settings = {
			["rust-analyzer"] = {
				lens = {
					enable = true,
				},
				checkOnSave = {
					enable = true,
					command = "clippy",
				},
			},
		},
	},
}

return options
