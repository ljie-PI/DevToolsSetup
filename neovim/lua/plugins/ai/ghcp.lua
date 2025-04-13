local M = {}

M.opts = {
  panel = {
    enabled = false, -- Don't enable
    -- auto_refresh = false,
    -- keymap = {
    --   jump_prev = "[[",
    --   jump_next = "]]",
    --   accept = "<CR>",
    --   refresh = "gr",
    --   open = "<M-CR>"
    -- },
    -- layout = {
    --   ---@position "top" | "left" | "right" | "horizontal" | "vertical"
    --   position = "bottom",
    --   ratio = 0.4
    -- },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    trigger_on_accept = true,
    hide_during_completion = true,
    debounce = 75,
    keymap = {
      accept = "<C-f>",
      accept_word = false,
      accept_line = false,
      next = "<C-l>",
      prev = "<C-h>",
      dismiss = "<ESC>",
    },
  },
  filetypes = {
    markdown = true,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  -- URL to authentication provider, if not "https://github.com/"
  auth_provider_url = nil,
  -- Current LSP default is gpt-35-turbo, supports gpt-4o-copilot
  copilot_model = "gpt-35-turbo",
}

return M
