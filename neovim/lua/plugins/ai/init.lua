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
    "ljie-PI/avante.nvim",
    lazy = true,
    event = "VeryLazy",
    build = avante.build_cmd(),
    opts = avante.opts,
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        "zbirenbaum/copilot.lua",
        opts = {
          -- Only use copilot.lua to support avante
          panel = {
            enabled = false,
          },
          suggestion = {
            enabled = false,
          },
        },
      },
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
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
