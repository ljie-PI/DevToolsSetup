local M = {}

M.opts = {
  nes = {
    debounce = 100,
    trigger = {
      events = { "InsertLeave", "TextChanged", "User SidekickNesDone" },
    },
    clear = {
      events = { "TextChangedI", "InsertEnter" },
      esc = true, -- clear next edit suggestions when pressing <Esc>
    },
  },
  cli = {
    win = {
      layout = "float", ---@type "float"|"left"|"bottom"|"top"|"right"
      -- options used when layout is "float"
      float = {
        width = 0.9,
        height = 0.9,
      },
      -- options used when layout is "left"|"bottom"|"top"|"right"
      split = {
        width = 0.36,
        height = 0.36,
      },
      keys = {
        hide_n = { "q", "hide", mode = "n", desc = "hide the terminal window" },
        hide_ctrl_q = { "<c-q>", "hide", mode = "nt", desc = "hide the terminal window" },
        stopinsert = { "<c-n>", "stopinsert", mode = "t", desc = "enter normal mode" },
        prompt = { "<c-p>", "prompt", mode = "t", desc = "insert prompt or context" },
      },
    },
    mux = {
      enabled = true,
      backend = vim.env.ZELLIJ and "zellij" or "tmux", -- default to tmux unless zellij is detected
      -- terminal: new sessions will be created for each CLI tool and shown in a Neovim terminal
      -- window: when run inside a terminal multiplexer, new sessions will be created in a new tab
      -- split: when run inside a terminal multiplexer, new sessions will be created in a new split
      create = "split",
      split = {
        vertical = true, -- vertical or horizontal split
        size = 0.36, -- size of the split (0-1 for percentage)
      },
    },
    tools = {
      claude = { cmd = { "claude" } },
      gemini = { cmd = { "gemini" } },
      qwen = { cmd = { "qwen" } },
      codex = { cmd = { "codex", "--search" } },
      opencode = {
        cmd = { "opencode" },
        env = { OPENCODE_THEME = "system" },
      },
    },
  },
}

M.keys = {
  {
    "<C-f>",
    function()
      if not require("sidekick").nes_jump_or_apply() then
        return "<C-f>"
      end
    end,
    expr = true,
    desc = "Goto/Apply Next Edit Suggestion",
    mode = { "n", "i" },
  },
  {
    "<leader>aa",
    function()
      require("sidekick.cli").toggle({
        filter = { installed = true },
      })
    end,
    desc = "Sidekick Toggle CLI",
  },
  {
    "<leader>ac",
    function()
      require("sidekick.cli").select({
        filter = { installed = true },
      })
    end,
    desc = "Select CLI",
  },
  {
    "<leader>ad",
    function()
      require("sidekick.cli").close()
    end,
    desc = "Detach a CLI Session",
  },
  {
    "<leader>af",
    function()
      require("sidekick.cli").send({
        msg = "{file}",
        filter = { installed = true },
      })
    end,
    desc = "Send File",
  },
  {
    "<leader>as",
    function()
      require("sidekick.cli").send({
        msg = "{selection}",
        filter = { installed = true },
      })
    end,
    desc = "Send Visual Selection",
    mode = { "v" },
  },
  {
    "<leader>ap",
    function()
      require("sidekick.cli").prompt()
    end,
    mode = { "n", "v" },
    desc = "Sidekick Select Prompt",
  },
  -- keybinding to tools directly
  {
    "<leader>aq",
    function()
      require("sidekick.cli").toggle({ name = "qwen", focus = true })
    end,
    desc = "Sidekick Toggle qwen",
  },
  {
    "<leader>ao",
    function()
      require("sidekick.cli").toggle({ name = "opencode", focus = true })
    end,
    desc = "Sidekick Toggle opencode",
  },
}

return M
