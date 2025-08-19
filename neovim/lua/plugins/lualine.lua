local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  update_in_insert = false,
  always_visible = true,
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width,
}

local mode = {
  "mode",
  fmt = function(str)
    return "-- " .. str .. " --"
  end,
}

local filetype = {
  "filetype",
  icons_enabled = false,
  icon = nil,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
}

local location = {
  "location",
  padding = 0,
}

local spaces = function()
  return "spaces: " .. vim.api.nvim_get_option_value("shiftwidth", { buf = 0 })
end

-- GitHub Copilot status
local copilot_status = function()
  local ok, copilot = pcall(require, "copilot.api")
  if ok and copilot.is_ready and copilot.is_ready() then
    local status_data = copilot.status.data
    if status_data and status_data.status then
      if status_data.status == "InProgress" then
        return " Copilot"
      elseif status_data.status == "Error" then
        return " Copilot"
      else
        return " Copilot"
      end
    else
      return " Copilot"
    end
  else
    local clients = vim.lsp.get_clients({ name = "copilot" })
    if #clients > 0 then
      return " Copilot"
    end
  end

  return " Copilot"
end

local lualine_opts = {
  options = {
    icons_enabled = true,
    theme = "auto",
    section_separators = { left = "", right = "" },
    component_separators = { left = "|", right = "|" },
    disabled_filetypes = {
      "Avante",
      "AvanteInput",
      "AvantePromptInput",
      "AvanteSelectedCode",
      "AvanteSelectedFiles",
      "AvanteTodos",
      "alpha",
      "dashboard",
      "NvimTree",
      "Outline",
    },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { branch, diff, diagnostics },
    lualine_c = { copilot_status },
    lualine_x = { spaces, "encoding", "fileformat", filetype },
    lualine_y = { "progress" },
    lualine_z = { location },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}

return {
  {
    "nvim-lualine/lualine.nvim",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = lualine_opts,
  },
}
