return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "folke/noice.nvim",
    event = "VimEnter",
    config = function() end,
    dependencies = { { "MunifTanjim/nui.nvim" } },
  },
  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    config = function()
      require "configs.twilight"
    end,
  },
  {
    "rcarriga/nvim-notify",
    lazy = false,
  },
  -- These are some examples, uncomment them if you want to see them work!
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
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
      },
    },
  },
  -- search & replace
  {
    "MagicDuck/grug-far.nvim",
    lazy = false,
    config = function()
      require("grug-far").setup {}
    end,
  },
  {
    "Bekaboo/deadcolumn.nvim",
    lazy = false,
  },
  {
    "knubie/vim-kitty-navigator",
    lazy = false,
  },
  {
    "fladson/vim-kitty",
    config = function()
      require("vim-kitty").setup()
    end,
  },
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    version = ">=1.0.0",
    config = function()
      require("smart-splits").setup()
    end,
  },
  {
    "karb94/neoscroll.nvim",
    enabled = true,
    event = "VeryLazy",
    config = function()
      require "plugins.configs.neoscroll"
    end,
  },
}
