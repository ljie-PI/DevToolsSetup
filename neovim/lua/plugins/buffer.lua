local bufline_opts = {
  options = {
    numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    show_tab_indicators = true,
    always_show_bufferline = true,
    show_buffer_icons = false,
    show_buffer_close_icons = false,
  }
}

return {
  {
    "famiu/bufdelete.nvim",
    lazy = true,
    event = "VeryLazy",
  },

  {
    "akinsho/bufferline.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = bufline_opts,
  }
}
