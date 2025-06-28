local avante = require("plugins.ai.avante")
local ghcp = require("plugins.ai.ghcp")

return {
  {
    "zbirenbaum/copilot.lua",
    lazy = true,
    event = "InsertEnter",
    cmd = { "Copilot", "Copilot auth", "Copilot status" },
    opts = ghcp.opts,
    config = function(_, opts)
      require("copilot").setup(opts)
    end,
  },

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = avante.build_cmd(),
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
      "MeanderingProgrammer/render-markdown.nvim",
      "zbirenbaum/copilot.lua",
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
    },
    opts = avante.opts,
    config = avante.setup
  },
}
