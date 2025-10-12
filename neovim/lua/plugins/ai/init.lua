local sidekick = require("plugins.ai.sidekick")
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
    "folke/sidekick.nvim",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      "zbirenbaum/copilot.lua",
    },
    opts = sidekick.opts,
    keys = sidekick.keys,
  },
}
