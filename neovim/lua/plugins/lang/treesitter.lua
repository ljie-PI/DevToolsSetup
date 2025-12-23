local M = {}

M.options = {
  highlight = { enable = true },
  indent = { enable = true },
  fold = { enable = true },
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "go",
    "javascript",
    "lua",
    "python",
    "rust",
    "tsx",
    "typescript",
  },
}

M.setup = function(opts)
  local ts = require("nvim-treesitter")
  ts.setup({
    install_dir = vim.fn.stdpath("data") .. "/site",
  })

  local ensure_installed = opts.ensure_installed or {}
  ts.install(ensure_installed)
  local group = vim.api.nvim_create_augroup("nvim-treesitter", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function(event)
      if opts.highlight and opts.highlight.enable then
        local lang = vim.treesitter.language.get_lang(event.match) or event.match
        pcall(vim.treesitter.start, event.buf, lang)
      end

      if opts.indent and opts.indent.enable then
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end

      if opts.fold and opts.fold.enable then
        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo.foldlevel = 3
      end
    end,
  })
end

return M
