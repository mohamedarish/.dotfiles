return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre", -- uncomment for format on save
		config = function()
			require "configs.conform"
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("nvchad.configs.lspconfig").defaults()
			require "configs.lspconfig"
		end,
	},

	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"lua-language-server",
				"stylua",
				"html-lsp",
				"css-lsp",
				"prettier",
				"gopls",
				"clang-format",
				"codelldb",
				"ruff",
				"black",
			},
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"vim",
				"lua",
				"luadoc",
				"vimdoc",
				"html",
				"css",
				"javascript",
				"json",
				"typescript",
				"go",
				"gomod",
				"gosum",
				"gotmpl",
				"gowork",
				"c",
				"llvm",
				"cmake",
				"make",
				"cpp",
				"python",
				"rust",
				"git_config",
				"git_rebase",
				"gitcommit",
				"gitignore",
				"markdown",
				"regex",
				"sql",
				"templ",
				"toml",
				"yaml",
			},
		},
	},
	{
		"olexsmir/gopher.nvim",
		ft = "go",
		config = function(_, opts)
			require("gopher").setup(opts)
		end,
		build = function()
			vim.cmd [[silent! GoInstallDeps]]
		end,
	},
	{
		"moliva/inlay-hints.nvim",
		branch = "feat/disable-tsserver-adapter",
		event = "VeryLazy",
	},
	{
		"rust-lang/rust.vim",
		ft = { "rust" },
		init = function()
			vim.g.rustfmt_autosave = 1
		end,
	},
	{
		"saecki/crates.nvim",
		tag = "stable",
		ft = { "rust", "toml" },
		config = function(_, opts)
			local crates = require "crates"
			crates.setup(opts)
			crates.show()
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		ft = { "rust" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"mfussenegger/nvim-dap",
			{
				"lvimuser/lsp-inlayhints.nvim",
				opts = {},
			},
		},
		config = function()
			vim.g.rustaceanvim = {
				inlay_hints = {
					highlight = "NonText",
				},
				tools = {
					hover_actions = {
						auto_focus = true,
					},
				},
				server = {
					on_attach = function(client, bufnr)
						local lsp_inlayhints = require "lsp-inlayhints"
						lsp_inlayhints.on_attach(client, bufnr)
						lsp_inlayhints.setup {}
						lsp_inlayhints.show()
					end,
				},
			}
		end,
	},
	{
		"mfussenegger/nvim-dap",
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		event = "VeryLazy",
		opts = {
			handlers = {},
			ensure_installed = {
				"codelldb",
			},
		},
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		event = "VeryLazy",
		config = function()
			local dap = require "dap"
			local dapui = require "dapui"

			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end

			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end

			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
}
