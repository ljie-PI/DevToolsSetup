local codeium = require("plugins.ai.codeium")
local avante = require("plugins.ai.avante")

return {
  {
    "Exafunction/codeium.nvim",
    lazy = true,
    event = "VeryLazy",
    cmd = "Codeium Auth",
    opts = codeium.opts,
  },

  {
    "yetone/avante.nvim",
    lazy = true,
    event = "VeryLazy",
    build = avante.build_cmd(),
    opts = avante.opts,
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}