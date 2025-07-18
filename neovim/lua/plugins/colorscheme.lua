local tokyonight_opts = {
  style = "storm",
}

local catppuccin_opts = {
  integrations = {
    aerial = true,
    alpha = true,
    cmp = true,
    dashboard = true,
    flash = true,
    grug_far = true,
    gitsigns = true,
    headlines = true,
    illuminate = true,
    indent_blankline = { enabled = true },
    leap = true,
    lsp_trouble = true,
    mason = true,
    markdown = true,
    mini = true,
    native_lsp = {
      enabled = true,
      underlines = {
        errors = { "undercurl" },
        hints = { "undercurl" },
        warnings = { "undercurl" },
        information = { "undercurl" },
      },
    },
    navic = { enabled = true, custom_bg = "lualine" },
    neotest = true,
    neotree = true,
    noice = true,
    notify = true,
    semantic_tokens = true,
    telescope = true,
    treesitter = true,
    treesitter_context = true,
    which_key = true,
  },
}

return {
  {
    "ljie-PI/helix-nvim",
    lazy = true,
    name = "helix",
  },

  {
    "folke/tokyonight.nvim",
    lazy = true,
    name = "tokyonight",
    opts = tokyonight_opts,
  },

  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = catppuccin_opts,
  },
}
