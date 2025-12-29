local nvim_util = require("utils")

local M = {}

M.opts = {
  -- debug = true,

  ---@alias Mode "agentic" | "legacy"
  mode = "agentic",

  ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | <acp_provider>
  provider = "opencode",
  providers = {
    copilot = {
      model = "claude-sonnet-4.5",
    },
  },
  acp_providers = {
    ["opencode"] = {
      command = "opencode",
      args = { "acp" },
    },
    ["qwen-code"] = {
      command = "qwen",
      args = { "--experimental-acp" },
    },
  },

  input = {
    provider = "native"
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
      next = "c]",
      prev = "c[",
    },
    jump = {
      next = "]]",
      prev = "[[",
    },
    submit = {
      normal = "<CR>",
      insert = "<C-g>",
    },
    sidebar = {
      apply_all = "A",
      apply_cursor = "a",
      switch_windows = "<Tab>",
      reverse_switch_windows = "<S-Tab>",
    },
    toggle = {
      suggestion = "<leader>aS",
    },
    stop = "<leader>as",
  },
  hints = { enabled = true },
  windows = {
    ---@type "right" | "left" | "top" | "bottom"
    position = "right",
    wrap = true,
    width = 36,       -- % based on available width
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
      floating = false,    -- Open the 'AvanteAsk' prompt in a floating window
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

function M.setup(_, opts)
  local avante_ok, avante = pcall(require, "avante")
  if not avante_ok then
    return
  end

  local orig_setup = avante.setup
  local ok, err = pcall(orig_setup, opts)
  if ok then
    return
  end

  if type(err) == "string"
      and err:match("You must setup copilot with either copilot.lua or copilot.vim")
  then
    vim.notify(
      "Avante Copilot Provider couldn't detect Copilot configuration.\n" ..
      "Please install and configure copilot.lua or copilot.vim first, then run :Copilot auth",
      vim.log.levels.WARN
    )
    return
  end

  error(err)
end

function M.build_cmd()
  if nvim_util.is_win() then
    return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
  else
    return "make BUILD_FROM_SOURCE=true"
  end
end

return M
