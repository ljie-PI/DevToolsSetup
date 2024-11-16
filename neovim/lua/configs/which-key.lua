local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {
  preset = "helix", -- false | "classic" | "modern" | "helix"
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
    mappings = false, -- disable keymap icons from rules
  },
  win = {
    no_overlap = true,
    border = "rounded",
    padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
    title = true,
    title_pos = "left",
    zindex = 1000,
    wo = {
      winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
    },
  },
  layout = {
    width = { min = 30 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
  },
  show_help = true, -- show help message on the command line when the popup is visible
  show_keys = true,
  keys = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  triggers = {
   { "<leader>", mode = { "n", "v" } },
 }
}

local nmappings = {
  {"<leader>/", "<cmd>lua require(\"Comment.api\").toggle.linewise.current()<cr>", desc = "Comment Current Line(s)", icon = nil },

  {
    { "<leader>b", group = "Buffer", icon = nil },
    { "<leader>b,", "<cmd>bprevious<cr>", desc = "Previous Buffer" },
    { "<leader>b.", "<cmd>bnext<cr>", desc = "Next Buffer" },
    { "<leader>bb", "<cmd>e#<cr>", desc = "Last Buffer" },
    { "<leader>bd", "<cmd>Bdelete<cr>", desc = "Close Buffer" },
    { "<leader>bl", "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>", desc = "List Buffers" },
  },

  {"<leader>D", "<cmd>lua vim.diagnostic.open_float()<cr>", desc = "Diagnose",  icon = nil },

  {
    { "<leader>d", group = "Debug", icon = nil },
    { "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
    { "<leader>dd", "<cmd>lua require('dap').continue()<cr>", desc = "Run Debug" },
    { "<leader>dl", "<cmd>lua require('dap.ext.vscode').load_launchjs(nil, { lldb = { 'c', 'cc', 'cpp', 'rust' } })<cr>", desc = "Start from Launch File" },
    { "<leader>ds", "<cmd>lua require('dap').step_over()<cr>", desc = "Step Over" },
    { "<leader>di", "<cmd>lua require('dap').step_into()<cr>", desc = "Step Into" },
    { "<leader>do", "<cmd>lua require('dap').step_out()<cr>", desc = "Step Out" },
    { "<Leader>dr", "<cmd>lua require('dap').repl.toggle()<cr>", desc = "Toggle REPL" },
    { "<Leader>dq", "<cmd>lua require('dap').quit()<cr>", desc = "Quit Debug" },
    { "<Leader>dx", "<cmd>lua require('dap').terminate()<cr>", desc = "Terminate Debug" },
  },

  {"<leader>F", "<cmd>lua vim.lsp.buf.format()<cr>", desc = "Format", icon = nil },

  {
    { "<leader>f", group = "Find", icon = nil },
    { "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", desc = "Find Buffer" },
    { "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", desc = "Find File" },
    { "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", desc = "Find Help Tag" },
    { "<leader>ft", "<cmd>lua require('telescope.builtin').live_grep()<cr>", desc = "Find Text" },
  },

  {
    { "<leader>g", group = "Go to", icon = nil },
    { "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", desc = "Go to Declaration" },
    { "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Go to Definition" },
    { "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", desc = "Go to Implementation" },
    { "<leader>gr", "<cmd>lua vim.lsp.buf.references()<cr>", desc = "Go to References" },
  },

  {
    { "<leader>l", group = "LSP", icon = nil },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
    { "<leader>ld", "<cmd>Telescope lsp_document_diagnostics<cr>", desc = "Document Diagnostics" },
    { "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", desc = "Format" },
    { "<leader>lI", "<cmd>LspInstallInfo<cr>", desc = "Installer Info" },
    { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
    { "<leader>lj", "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>", desc = "Next Diagnostic" },
    { "<leader>lk", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic" },
    { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
    { "<leader>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", desc = "Quickfix" },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
    { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
    { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
    { "<leader>lw", "<cmd>Telescope lsp_workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
  },

  {"<leader>m", "<cmd>HopWord<cr>", desc = "Move to", icon = nil },

  {
    { "<leader>p", group = "Packer", icon = nil },
    { "<leader>pc", "<cmd>PackerCompile<cr>", desc = "Compile" },
    { "<leader>pi", "<cmd>PackerInstall<cr>", desc = "Install" },
    { "<leader>pS", "<cmd>PackerStatus<cr>", desc = "Status" },
    { "<leader>ps", "<cmd>PackerSync<cr>", desc = "Sync" },
    { "<leader>pu", "<cmd>PackerUpdate<cr>", desc = "Update" },
  },

  {
    { "<leader>w", group = "Window", icon = nil },
    { "<leader>we", "<cmd>NvimTreeToggle<cr>", desc = "File Explorer" },
    { "<leader>wh", "<cmd>split<cr>", desc = "Horizontal Split" },
    { "<leader>wv", "<cmd>vsplit<cr>", desc = "Vertical Split" },
  },
}

local vmappings = {
  { "<leader>/", "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", desc = "Comment Lines", mode = "v" },
}

which_key.add(nmappings)
which_key.add(vmappings)
which_key.setup(opts)
