local M = {}

M.opts = {
  enable_cmp_source = false,
  virtual_text = {
    enabled = true,
    -- Set to true if you never want completions to be shown automatically.
    manual = false,
    -- Set to false to disable all key bindings for managing completions.
    map_keys = true,
    -- Key bindings for managing completions in virtual text mode.
    key_bindings = {
        accept = "<C-f>",
        prev = "<C-h>",
        next = "<C-l>",
    }
  }
}

return M
