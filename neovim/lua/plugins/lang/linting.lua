local M = {}

M.options = {
  debug = false,
  events = { "BufWritePost", "BufReadPost", "InsertLeave" },
  linters_by_ft = {
    bash = { "bash" },
    javascript = { "eslint_d" },
    lua = { "luacheck" },
    python = { "pylint" },
    typescript = { "eslint_d" },
    typescriptreact = { "eslint_d" },
  },
}

M.setup = function(_, opts)
  local lint = require("lint")
  lint.linters_by_ft = opts.linters_by_ft

  vim.api.nvim_create_autocmd(opts.events, {
    group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
    callback = function()
      lint.try_lint()
    end,
  })
end

return M
