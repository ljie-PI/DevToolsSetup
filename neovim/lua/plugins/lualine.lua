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
  cond = hide_in_width
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
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local codeium_status = function()
  local status = require("codeium.virtual_text").status()
  local prefix = "Codeium: "
  if status.state == "idle" then
      return prefix .. "-"
    end
  if status.state == "waiting" then
    return prefix .. "*"
    end
  if status.state == "completions" and status.total > 0 then
        return prefix .. string.format('%d/%d', status.current, status.total)
    end
  return prefix .. "0"
end

local lualine_opts = {
  options = {
    icons_enabled = true,
    theme = "auto",
    section_separators = { left = "", right = "" },
    component_separators = { left = "|", right = "|" },
    disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {mode},
    lualine_b = {branch, diff, diagnostics},
    lualine_c = {codeium_status},
    lualine_x = {spaces, "encoding", "fileformat", filetype},
    lualine_y = {"progress"},
    lualine_z = {location}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
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
      "Exafunction/codeium.nvim",
    },
    opts = lualine_opts,
  }
}
