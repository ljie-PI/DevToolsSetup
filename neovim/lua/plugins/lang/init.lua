local nvim_util = require("utils")
local formatting = require("plugins.lang.formatting")
local linting = require("plugins.lang.linting")
local treesitter = require("plugins.lang.treesitter")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = not nvim_util.is_opening_files(),
    build = ":TSUpdate",
    event = { "LazyFile", "VeryLazy" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts_extend = { "ensure_installed" },
    opts = treesitter.options,
    config = function(_, opts)
      treesitter.setup(opts)
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    lazy = true,
    ft = { "markdown", "Avante" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    opts = {
      file_types = { "markdown", "Avante" },
    },
  },

  {
    "stevearc/conform.nvim",
    lazy = true,
    keys = {
      {
        "<leader>F",
        function()
          require("conform").format({ async = true })
        end,
        mode = "n",
        desc = "Format buffer",
      },
    },
    opts = formatting.options,
  },

  {
    "mfussenegger/nvim-lint",
    event = "LazyFile",
    opts = linting.options,
    config = linting.setup,
  },

  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = "VeryLazy",
    config = function(_, opts)
      local handlers = require("plugins.lang.handlers")
      handlers.setup()
      local languages = require("plugins.lang.lsp")
      languages.setup()
    end
  },
}
