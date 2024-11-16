local ls_status_ok, null_ls = pcall(require, "null-ls")
if not ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting

null_ls.setup {
  debug = false,
  sources = {
    formatting.stylua,
    formatting.clang_format,
    formatting.dxfmt,
    formatting.shellharden,
    formatting.black.with({
      extra_args = { "--fast" }
    }),
    formatting.prettier.with({
      extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
      extra_filetypes = { "toml" }
    })
  }
}
