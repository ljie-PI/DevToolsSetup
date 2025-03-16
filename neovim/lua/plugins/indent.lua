local ibl_opts = {
  indent = { char = "╎", },
  scope = { enabled = false },
}

return {
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = true,
    event = "VeryLazy",
    main = "ibl",
    opts = ibl_opts,
  }
}
