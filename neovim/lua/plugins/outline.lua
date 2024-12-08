local outline_opts = {
  outline_window = {
    position = "right",
    width = 18, -- Percentage of width

    wrap = true,
    show_cursorline = true,
    focus_on_open = true,
  },

  -- These keymaps can be a string or a table for multiple keys.
  -- Set to `{}` to disable. (Using 'nil' will fallback to default keys)
  keymaps = {
    show_help = '?',
    close = {'<Esc>', 'q'},
    goto_location = '<Cr>',
    peek_location = 'o',
    goto_and_close = '<S-Cr>',
    -- Open LSP/provider-dependent symbol hover information
    hover_symbol = '<C-space>',
    -- Preview location code of the symbol under cursor
    toggle_preview = 'K',
    rename_symbol = 'r',
    code_actions = 'a',
    -- These fold actions are collapsing tree nodes, not code folding
    fold = 'h',
    unfold = 'l',
    fold_toggle = '<Tab>',
    fold_toggle_all = '<S-Tab>',
    fold_all = 'W',
    unfold_all = 'E',
    fold_reset = 'R',
    -- Move down/up by one line and peek_location immediately.
    -- You can also use outline_window.auto_jump=true to do this for any
    -- j/k/<down>/<up>.
    down_and_jump = '<C-j>',
    up_and_jump = '<C-k>',
  },

}

return {
  {
    "hedyhli/outline.nvim",
    lazy = true,
    event = "VeryLazy",
    cmd = "Outline",
    opts = outline_opts,
  },
}
