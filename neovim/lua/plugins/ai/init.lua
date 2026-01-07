local ghcp = require("plugins.ai.ghcp")
local avante = require("plugins.ai.avante")
local sidekick = require("plugins.ai.sidekick")

local function get_ai_assistant_preference()
  local preference_file = vim.fn.stdpath("data") .. "/.ai_preference"
  local file = io.open(preference_file, "r")
  if file then
    local content = file:read("*all")
    file:close()
    content = content:gsub("%s+", "") -- trim whitespace
    if content == "sidekick" or content == "avante" then
      return content
    end
  end
  return "sidekick" -- default
end

vim.g.ai_assistant = get_ai_assistant_preference()

local copilot_plugin = {
  "zbirenbaum/copilot.lua",
  lazy = true,
  event = "InsertEnter",
  cmd = { "Copilot", "Copilot auth", "Copilot status" },
  opts = ghcp.opts,
  config = function(_, opts)
    require("copilot").setup(opts)
  end,
}

local sidekick_plugin = {
  "folke/sidekick.nvim",
  lazy = true,
  event = "VeryLazy",
  dependencies = {
    "zbirenbaum/copilot.lua",
  },
  opts = sidekick.opts,
  keys = sidekick.keys,
}

local avante_plugin = {
  "yetone/avante.nvim",
  event = "VeryLazy",
  build = avante.build_cmd(),
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
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
  config = avante.setup,
}

-- Build plugins table based on configuration
local plugins = { copilot_plugin }

if vim.g.ai_assistant == "sidekick" then
  table.insert(plugins, sidekick_plugin)
elseif vim.g.ai_assistant == "avante" then
  table.insert(plugins, avante_plugin)
end

return plugins
