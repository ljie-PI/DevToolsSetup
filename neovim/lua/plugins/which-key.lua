local nmappings = {
  {"<leader>/", "<CMD>lua require(\"Comment.api\").toggle.linewise.current()<CR>", desc = "Comment Current Line(s)", icon = nil, mode = "n" },

  {
    { "<leader>b", group = "Buffer", icon = nil },
    { "<leader>b,", "<CMD>bprevious<CR>", desc = "Previous Buffer" },
    { "<leader>b.", "<CMD>bnext<CR>", desc = "Next Buffer" },
    { "<leader>bb", "<CMD>e#<CR>", desc = "Last Buffer" },
    { "<leader>bd", "<CMD>Bdelete<CR>", desc = "Close Buffer" },
    { "<leader>bl", "<CMD>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>", desc = "List Buffers" },
  },

  {"<leader>a", group = "AI Assistant", icon = nil },

  {"<leader>D", "<CMD>lua vim.diagnostic.open_float()<CR>", desc = "Diagnose",  icon = nil },

  {
    { "<leader>d", group = "Debug", icon = nil },
    { "<leader>db", "<CMD>lua require('dap').toggle_breakpoint()<CR>", desc = "Toggle Breakpoint" },
    { "<leader>dd", "<CMD>lua require('dap').continue()<CR>", desc = "Run Debug" },
    { "<leader>dl", "<CMD>lua require('dap.ext.vscode').load_launchjs(nil, { lldb = { 'c', 'cc', 'cpp', 'rust' } })<CR>", desc = "Start from Launch File" },
    { "<leader>ds", "<CMD>lua require('dap').step_over()<CR>", desc = "Step Over" },
    { "<leader>di", "<CMD>lua require('dap').step_into()<CR>", desc = "Step Into" },
    { "<leader>do", "<CMD>lua require('dap').step_out()<CR>", desc = "Step Out" },
    { "<Leader>dr", "<CMD>lua require('dap').repl.toggle()<CR>", desc = "Toggle REPL" },
    { "<Leader>dq", "<CMD>lua require('dap').quit()<CR>", desc = "Quit Debug" },
    { "<Leader>dx", "<CMD>lua require('dap').terminate()<CR>", desc = "Terminate Debug" },
  },

  {"<leader>F", "<CMD>lua vim.lsp.buf.format()<CR>", desc = "Format", icon = nil },

  {
    { "<leader>f", group = "Find", icon = nil },
    { "<leader>fb", "<CMD>lua require('telescope.builtin').buffers()<CR>", desc = "Find Buffer" },
    { "<leader>ff", "<CMD>lua require('telescope.builtin').find_files()<CR>", desc = "Find File" },
    { "<leader>fh", "<CMD>lua require('telescope.builtin').help_tags()<CR>", desc = "Find Help Tag" },
    { "<leader>ft", "<CMD>lua require('telescope.builtin').live_grep()<CR>", desc = "Find Text" },
  },

  {
    { "<leader>g", group = "Go to", icon = nil },
    { "<leader>gD", "<CMD>lua vim.lsp.buf.declaration()<CR>", desc = "Go to Declaration" },
    { "<leader>gd", "<CMD>lua vim.lsp.buf.definition()<CR>", desc = "Go to Definition" },
    { "<leader>gi", "<CMD>lua vim.lsp.buf.implementation()<CR>", desc = "Go to Implementation" },
    { "<leader>gr", "<CMD>lua vim.lsp.buf.references()<CR>", desc = "Go to References" },
  },

  {"<leader>L", "<CMD>Lazy<CR>", desc = "Show Lazy UI", icon = nil },

  {
    { "<leader>l", group = "LSP", icon = nil },
    { "<leader>la", "<CMD>lua vim.lsp.buf.code_action()<CR>", desc = "Code Action" },
    { "<leader>ld", "<CMD>Telescope lsp_document_diagnostics<CR>", desc = "Document Diagnostics" },
    { "<leader>lf", "<CMD>lua vim.lsp.buf.formatting()<CR>", desc = "Format" },
    { "<leader>lI", "<CMD>LspInstallInfo<CR>", desc = "Installer Info" },
    { "<leader>li", "<CMD>LspInfo<CR>", desc = "Info" },
    { "<leader>lj", "<CMD>lua vim.lsp.diagnostic.goto_next()<CR>", desc = "Next Diagnostic" },
    { "<leader>lk", "<CMD>lua vim.lsp.diagnostic.goto_prev()<CR>", desc = "Prev Diagnostic" },
    { "<leader>ll", "<CMD>lua vim.lsp.codelens.run()<CR>", desc = "CodeLens Action" },
    { "<leader>lq", "<CMD>lua vim.lsp.diagnostic.set_loclist()<CR>", desc = "Quickfix" },
    { "<leader>lr", "<CMD>lua vim.lsp.buf.rename()<CR>", desc = "Rename" },
    { "<leader>lS", "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "Workspace Symbols" },
    { "<leader>ls", "<CMD>Telescope lsp_document_symbols<CR>", desc = "Document Symbols" },
    { "<leader>lw", "<CMD>Telescope lsp_workspace_diagnostics<CR>", desc = "Workspace Diagnostics" },
  },

  {"<leader>m", "<CMD>HopWord<CR>", desc = "Move to", icon = nil },

  {
    { "<leader>p", group = "Packer", icon = nil },
    { "<leader>pc", "<CMD>PackerCompile<CR>", desc = "Compile" },
    { "<leader>pi", "<CMD>PackerInstall<CR>", desc = "Install" },
    { "<leader>pS", "<CMD>PackerStatus<CR>", desc = "Status" },
    { "<leader>ps", "<CMD>PackerSync<CR>", desc = "Sync" },
    { "<leader>pu", "<CMD>PackerUpdate<CR>", desc = "Update" },
  },

  {
    { "<leader>w", group = "Window", icon = nil },
    { "<leader>we", "<CMD>NvimTreeToggle<CR>", desc = "File Explorer" },
    { "<leader>wo", "<CMD>Outline<CR>", desc = "Outline Symbols" },
    { "<leader>wh", "<CMD>split<CR>", desc = "Horizontal Split" },
    { "<leader>wv", "<CMD>vsplit<CR>", desc = "Vertical Split" },
  },
}

local vmappings = {
  {"<leader>/", "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", desc = "Comment Lines", mode = "v" },

  {"<leader>a", group = "AI Assistant", icon = nil, mode = "v" },

  {
    { "<leader>d", group = "Debug", icon = nil, mode = "v" },
    { "<leader>de", "<CMD>lua require('dapui').eval()<CR>", desc = "Evaluate an Expression", mode = "v" },
  },

  {
    { "<leader>f", group = "Find", icon = nil, mode = "v" },
    { "<leader>ft", "y<ESC>:Telescope live_grep default_text=<c-r>0<CR>", desc = "Search Current Selection", mode = "v" },
  },
}

local whichkey_opts = {
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
  },
}

return {
  {
    "folke/which-key.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = whichkey_opts,
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    config = function(_, opts)
      local which_key = require("which-key")
      which_key.setup(opts)
      which_key.add(nmappings)
      which_key.add(vmappings)
    end
  }
}
