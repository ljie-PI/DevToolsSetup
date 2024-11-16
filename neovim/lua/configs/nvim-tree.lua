local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local api_status_ok, nvim_tree_api = pcall(require, "nvim-tree.api")
if not api_status_ok then
  return
end

-- local function current_width_or_default()
--   local width = 15  -- default width
--
--   local windows = vim.api.nvim_list_wins()
--   local win_num = #windows
--   for _, win in ipairs(windows) do
--     local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
--     if bufname:match("NvimTree_") and win_num > 1 then
--         width = vim.api.nvim_win_get_width(win)
--     end
--   end
--
--   return width
-- end

local function customized_on_attach(bufnr)
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  -- default mappings
  nvim_tree_api.config.mappings.default_on_attach(bufnr)
  -- custom mappings
  vim.keymap.set('n', 'l', nvim_tree_api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', 'h', nvim_tree_api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', '<CR>', nvim_tree_api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'o', nvim_tree_api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'v', nvim_tree_api.node.open.vertical, opts('Open: Vertical Split'))
end

local keymap = vim.api.nvim_set_keymap
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

nvim_tree.setup {
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  renderer = {
    root_folder_modifier = ":t",
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  view = {
    width = {
      min = 30,
      max = "20%",
    },
    side = "left",
    adaptive_size = true,
  },
  on_attach = customized_on_attach,
}

