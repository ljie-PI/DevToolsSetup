local M = {}

M.options = {
  formatters_by_ft = {
    bash = { "shellharden" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    go = { "goimports", "gofumpt" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    lua = { "stylua" },
    python = { "isort", "black" },
    rust = { "rustfmt" },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
  -- format_on_save = { timeout_ms = 5000 },
}

return M
