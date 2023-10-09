local cmp = require "cmp"
--
local plugins = {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				-- python
				"black",
				"debugpy",
				"mypy",
				"ruff",
				-- "pyright", -- install using pip cuz npm sucks

				-- lua
				"lua-language-server",
				"luacheck",
				"stylua",

				-- c and cpp
				"clangd",
				"clang-format",
				"codelldb",

				-- markdown
				"marksman",
				-- "markdownlint", -- use homebrew

				-- toml
				"taplo",

				-- yaml
				"yaml-language-server",
				"yamllint",
				"yamlfmt",

				--json
				"json-lsp",
				"jsonlint",
				"fixjson",

				-- go
				"gopls",
				"gomodifytags",

				-- html
				"emmet_ls",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require "plugins.configs.lspconfig"
			require "custom.configs.lspconfig"
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		dependencies = "neovim/nvim-lspconfig",
		opts = function()
			return require "custom.configs.rust-tools"
		end,
		config = function(_, opts)
			require("core.utils").load_mappings "rust_tools"
			require("rust-tools").setup(opts)
		end,
	},
	{
		"mfussenegger/nvim-dap",
		init = function()
			require("core.utils").load_mappings "dap"
		end,
	},
	{
		"saecki/crates.nvim",
		ft = { "toml" },
		config = function(_, opts)
			local crates = require "crates"
			crates.setup(opts)
			require("cmp").setup.buffer {
				sources = { { name = "crates" } },
			}
			crates.show()
			require("core.utils").load_mappings "crates"
		end,
	},
	{
		"rust-lang/rust.vim",
		ft = "rust",
		init = function()
			vim.g.rustfmt_autosave = 1
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		lazy = false,
		config = function(_, opts)
			require("nvim-dap-virtual-text").setup()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		opts = function()
			local M = require "plugins.configs.cmp"
			M.completion.completeopt = "menu,menuone,noselect"
			M.mapping["<CR>"] = cmp.mapping.confirm {
				behavior = cmp.ConfirmBehavior.Insert,
				select = false,
			}
			table.insert(M.sources, { name = "crates" })
			return M
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = "mfussenegger/nvim-dap",
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
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		config = function(_, opts)
			local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(path)
			require("core.utils").load_mappings "dap_python"
		end,
	},
	-- {
	-- 	"jose-elias-alvarez/null-ls.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = function()
	-- 		return require "custom.configs.null-ls"
	-- 	end,
	-- },
	{
		"mattn/efm-langserver",
		event = "VeryLazy",
		opts = function()
			return require "custom.config.efm-ls"
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			handlers = {},
		},
	},
	{
		"andweeb/presence.nvim",
		event = "VeryLazy",
		opts = {
			-- General options
			auto_update = true,
			neovim_image_text = "The One True Text Editor",
			main_image = "file",
			client_id = "793271441293967371",
			log_level = nil,
			debounce_timeout = 10,
			enable_line_number = false,
			blacklist = {},
			buttons = true,
			file_assets = {},
			show_time = true,

			-- Rich Presence text options
			editing_text = "Editing %s",
			file_explorer_text = "Browsing %s",
			git_commit_text = "Committing changes",
			plugin_manager_text = "Managing plugins",
			reading_text = "Reading %s",
			workspace_text = "Working on %s",
			line_number_text = "Line %s out of %s",
		},
	},
	{
		"kdheepak/lazygit.nvim",
		event = "BufEnter",
		cmd = { "LazyGit" },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("core.utils").load_mappings "lazygit"
		end,
	},
	-- {
	--     "gorbit99/codewindow.nvim",
	--     event = "BufEnter *.*",
	--     config = function()
	--         local codewindow = require "codewindow"
	--         codewindow.setup {
	--             active_in_terminals = false,
	--             auto_enable = true,
	--             exclude_filetypes = { "help" },
	--             max_minimap_height = nil,
	--             max_lines = nil,
	--             minimap_width = 10,
	--             use_lsp = true,
	--             use_treesitter = true,
	--             use_git = true,
	--             width_multiplier = 4,
	--             z_index = 1,
	--             show_cursor = true,
	--             screen_bounds = "lines",
	--             window_border = "single",
	--             relative = "win",
	--             events = { "TextChanged", "InsertLeave", "DiagnosticChanged", "FileWritePost" },
	--         }
	--         codewindow.apply_default_keybinds()
	--     end,
	-- },
	{
		"f-person/git-blame.nvim",
		event = "BufEnter *.*",
		opts = {},
	},
	{
		"wintermute-cell/gitignore.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim", -- optional: for multi-select
		},
		cmd = "Gitignore",
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
	-- {
	--     "xiyaowong/transparent.nvim",
	--     lazy = false,
	--     opts = {},
	--     config = function()
	--         require("core.utils").load_mappings "transparent"
	--     end,
	-- },
}

return plugins
