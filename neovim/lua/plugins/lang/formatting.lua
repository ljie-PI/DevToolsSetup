local M = {}

M.options = {
  formatters_by_ft = {
    bash = { "shellharden" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    go = {
      "goimports",
      "gofumpt",
    },
    javascript = { "prettier" },
    lua = { "stylua" },
    python = {
      "ruff_fix",
      "ruff_format",
      "ruff_organize_imports",
    },
    rust = { "rustfmt" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
  -- format_on_save = { timeout_ms = 5000 },
}

return M
