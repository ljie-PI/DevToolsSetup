local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Plugins
return packer.startup(function(use)
  -- Basic
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "nvim-tree/nvim-web-devicons"
  use "nvim-tree/nvim-tree.lua"
  use "nvim-telescope/telescope.nvim"
  use "famiu/bufdelete.nvim"
  use "akinsho/bufferline.nvim"
  use "nvim-lualine/lualine.nvim"
  use "windwp/nvim-autopairs"
  use "numToStr/Comment.nvim"
  use "phaazon/hop.nvim"
  use "folke/tokyonight.nvim"
  use "folke/which-key.nvim"

  -- Completion plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- Buffer completions
  use "hrsh7th/cmp-path" -- Path completions
  use "hrsh7th/cmp-nvim-lsp" -- LSP completions

  -- LSP
  use "neovim/nvim-lspconfig" -- Enable LSP
  use "nvimtools/none-ls.nvim" -- LSP diagnostics and code actions

  -- Debugging
  use "mfussenegger/nvim-dap"
  use "nvim-neotest/nvim-nio"
  use "rcarriga/nvim-dap-ui"

  -- AI Copilots
  use {
    'Exafunction/codeium.vim',
    config = function ()
      vim.keymap.set('i', '<C-f>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
      vim.keymap.set('i', '<C-h>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
      vim.keymap.set('i', '<C-l>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end

end)
