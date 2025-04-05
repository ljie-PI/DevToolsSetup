local nvim_util = require("utils")

local M = {}

M.opts = {
  ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
  -- provider = "azure",
  -- auto_suggestions_provider = nil,
  azure = {
    endpoint = "https://ljie-gpt-demo.openai.azure.com",
    deployment = "gpt-4o",
    api_version = "2024-08-01-preview",
    timeout = 30000,
    temperature = 0,
    max_tokens = 4096,
  },
  -- provider = "copilot",
  -- copilot = {
  --   model = "claude-3.5-sonnet",
  -- },

  ---Specify the special dual_boost mode
  ---1. enabled: Whether to enable dual_boost mode. Default to false.
  ---2. first_provider: The first provider to generate response. Default to "openai".
  ---3. second_provider: The second provider to generate response. Default to "claude".
  ---4. prompt: The prompt to generate response based on the two reference outputs.
  ---5. timeout: Timeout in milliseconds. Default to 60000.
  ---How it works:
  --- When dual_boost is enabled, avante will generate two responses from the first_provider and second_provider respectively. Then use the response from the first_provider as provider1_output and the response from the second_provider as provider2_output. Finally, avante will generate a response based on the prompt and the two reference outputs, with the default Provider as normal.
  ---Note: This is an experimental feature and may not work as expected.
  dual_boost = {
    enabled = false,
  },
  behaviour = {
    auto_suggestions = false,
    auto_set_highlight_group = true,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = false,
    support_paste_from_clipboard = false,
    minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
  },
  mappings = {
    diff = {
      ours = "co",
      theirs = "ct",
      all_theirs = "ca",
      both = "cb",
      cursor = "cc",
      next = "]x",
      prev = "[x",
    },
    suggestion = {
      accept = "<C-f>",
      next = "<C-l>",
      prev = "<C-h>",
      dismiss = "<ESC>",
    },
    jump = {
      next = "]]",
      prev = "[[",
    },
    submit = {
      normal = "<CR>",
      insert = "<C-f>",
    },
    sidebar = {
      apply_all = "A",
      apply_cursor = "a",
      switch_windows = "<Tab>",
      reverse_switch_windows = "<S-Tab>",
    },
  },
  hints = { enabled = true },
  windows = {
    ---@type "right" | "left" | "top" | "bottom"
    position = "right",
    wrap = true,
    width = 30, -- % based on available width
    sidebar_header = {
      enabled = true, -- true, false to enable/disable the header
      ---@type "left" | "center" | "right"
      align = "left",
      rounded = true,
    },
    input = {
      prefix = "> ",
      height = 8,
    },
    edit = {
      border = "rounded",
      start_insert = true, -- Start insert mode when opening the edit window
    },
    ask = {
      floating = false, -- Open the 'AvanteAsk' prompt in a floating window
      start_insert = true, -- Start insert mode when opening the ask window
      border = "rounded",
      ---@type "ours" | "theirs"
      focus_on_apply = "ours", -- which diff to focus after applying
    },
  },
  diff = {
    autojump = true,
    list_opener = "copen",
    --- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
    --- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
    --- Disable by setting to -1.
    override_timeoutlen = 500,
  },
}

function M.build_cmd()
  if nvim_util.is_win() then  
    return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
  else
    return "make BUILD_FROM_SOURCE=true"
  end
end

return M
