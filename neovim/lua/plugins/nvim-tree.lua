local function customized_on_attach(bufnr)
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  local nvim_tree_api = require("nvim-tree.api")
  -- default mappings
  nvim_tree_api.config.mappings.default_on_attach(bufnr)
  -- custom mappings
  vim.keymap.set("n", "l", nvim_tree_api.tree.change_root_to_node, opts("CD"))
  vim.keymap.set("n", "h", nvim_tree_api.tree.change_root_to_parent, opts("Up"))
  vim.keymap.set("n", "<CR>", nvim_tree_api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "o", nvim_tree_api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "v", nvim_tree_api.node.open.vertical, opts("Open: Vertical Split"))
end

local nvimtree_opts = {
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

return {
  {
    "nvim-tree/nvim-tree.lua",
    lazy = true,
    event = "VeryLazy",
    cmd = "NvimTreeToggle",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = nvimtree_opts,
  },
}
