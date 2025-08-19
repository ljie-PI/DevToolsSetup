local function dap_setup()
  local dap = require("dap")

  dap.adapters.lldb = {
    type = "executable",
    command = vim.fn.exepath("lldb-dap"), -- adjust as needed, must be absolute path
    name = "lldb"
  }
  dap.configurations.cpp = {
    {
      name = "Launch",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
    }
  }
  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp
end

local dapui_opts = {
  expand_lines = true,
  icons = { expanded = "", collapsed = "", circular = "" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  layouts = {
    {
      elements = {
        { id = "scopes",      size = 0.33 },
        { id = "breakpoints", size = 0.17 },
        { id = "stacks",      size = 0.25 },
        { id = "watches",     size = 0.25 },
      },
      size = 0.33,
      position = "right",
    },
    {
      elements = {
        { id = "repl",    size = 0.45 },
        { id = "console", size = 0.55 },
      },
      size = 0.27,
      position = "bottom",
    },
  },
  floating = {
    max_height = 0.9,
    max_width = 0.5,             -- Floats will be treated as percentage of your screen.
    border = vim.g.border_chars, -- Border style. Can be 'single', 'double' or 'rounded'
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
}

local function dapui_setup(_, opts)
  local dap = require("dap")
  local dapui = require("dapui")

  dapui.setup(opts)
  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end
end

local virt_text_opts = {
  enabled = true,
  enabled_commands = true,
  highlight_changed_variables = true,
  highlight_new_as_changed = true,
  show_stop_reason = true,
  commented = false,
  only_first_definition = true,
  all_references = false,
  clear_on_continue = true,
  display_callback = function(variable, buf, stackframe, node, options)
    if options.virt_text_pos == 'inline' then
      return ' = ' .. variable.value:gsub("%s+", " ")
    else
      return variable.name .. ' = ' .. variable.value:gsub("%s+", " ")
    end
  end,
  virt_text_pos = vim.fn.has('nvim-0.10') == 1 and 'inline' or 'eol',
}

return {
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    event = "VeryLazy",
    config = dap_setup,
  },

  {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    opts = dapui_opts,
    config = dapui_setup,
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    opts = virt_text_opts,
  }
}
