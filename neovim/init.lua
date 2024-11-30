if vim.fn.has("nvim-0.10.0") == 0 then
  vim.api.nvim_echo({
    { "Please check if you have Neovim >= 0.10.0\n", "ErrorMsg" },
  }, true, {})
  vim.fn.getchar()
  vim.cmd([[quit]])
  return {}
end

require("configs")
