local plugins = {
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
    opts = {
      inlay_hints = {
        enabled = true,
      },
    },
  },
  {
    "simrat39/inlay-hints.nvim",
    event = "VeryLazy",
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- js and ts
        "eslint-lsp",
        "prettierd",
        "typescript-language-server",
        "css-lsp",

        -- python
        "black",
        "debugpy",
        "mypy",
        "ruff",
        "pyright",

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
        "markdownlint",

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
      },
    },
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function()
      require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
  },
  -- {
  --   'mrcjkb/rustaceanvim',
  --   version = '^3',
  --   ft = { 'rust' },
  --   dependencies = "neovim/nvim-lspconfig",
  --   config = function()
  --     vim.g.rustaceanvim = {
  --       server = {
  --         on_attach = function(_, bufnr)
  --           vim.lsp.inlay_hint(bufnr, true)
  --         end,
  --         settings = {
  --           ["rust-analyzer"] = {
  --             lens = {
  --                   enable = true,
  --               },
  --               checkOnSave = {
  --                   enable = true,
  --                   command = "clippy",
  --               },
  --           },
  --         },
  --       }
  --     }
  --   end,
  -- },
  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    config = function(_, opts)
      local crates = require "crates"
      crates.setup(opts)
      crates.show()
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "html",
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local opts = require "plugins.configs.treesitter"
      opts.ensure_installed = {
        "lua",
        "typescript",
        "javascript",
        "rust",
        "python",
        "tsx",
        "html",
        "css",
      }
      return opts
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local M = require "plugins.configs.cmp"
      table.insert(M.sources, { name = "crates" })
    end,
  },
  -- {
  --     "f-person/git-blame.nvim",
  --     event = "BufEnter *.*",
  --     opts = {},
  -- },
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
    "stevearc/dressing.nvim",
    opts = {},
    lazy = false,
  },
}

return plugins
