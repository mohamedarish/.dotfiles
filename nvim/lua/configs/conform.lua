local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		css = { "prettierd" },
		html = { "prettierd" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
		json = { "prettierd" },
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescriptreact = { "prettierd" },
		vue = { "prettierd" },
		shell = { "shfmt" },
		markdown = { "mdformat" },
	},

	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},
}

require("conform").setup(options)
