local nvim_util = require("utils")

local function null_ls_setup()
  local null_ls = require("null-ls")
  local formatting = null_ls.builtins.formatting

  null_ls.setup {
    debug = false,
    sources = {
      formatting.stylua,
      formatting.clang_format,
      formatting.dxfmt,
      formatting.shellharden,
      formatting.black.with({
        extra_args = { "--fast" }
      }),
      formatting.prettier.with({
        extra_filetypes = { "toml" }
      }),
    }
  }
end

local treesister_opts = {
  highlight = { enable = true },
  indent = { enable = true },
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "diff",
    "html",
    "javascript",
    "json",
    "jsonc",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "rust",
    "tsx",
    "typescript",
  },
  textobjects = {
    move = {
      enable = true,
      goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
      goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
      goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
      goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
    },
  },
}

return {
  {
    "nvimtools/none-ls.nvim",
    lazy = true,
    config = null_ls_setup,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = not nvim_util.is_opening_files(),
    build = ":TSUpdate",
    event = { "LazyFile", "VeryLazy" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts_extend = { "ensure_installed" },
    opts = treesister_opts,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      "nvimtools/none-ls.nvim",
    },
    config = function(_, opts)
      local handlers = require("plugins.lang.handlers")
      handlers.setup()
      local languages = require("plugins.lang.lsp")
      languages.setup()
    end
  },
}
