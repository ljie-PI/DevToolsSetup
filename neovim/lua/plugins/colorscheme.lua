local rosepine_opts = {
  variant = "moon", -- auto, main, moon, or dawn
  dark_variant = "moon",
  extend_background_behind_borders = true,
  styles = {
    bold = true,
    italic = true,
    transparency = false,
  },
}

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
    "rose-pine/neovim",
    lazy = true,
    name = "rose-pine",
    opts = rosepine_opts,
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
