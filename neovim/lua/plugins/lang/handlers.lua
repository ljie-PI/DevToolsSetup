local nvim_util = require("utils")

local M = {}

local function win_norm_uri(uri)
  local new_uri = uri:gsub("file:///(%l%%3A)", function(drive)
    return "file:///" .. drive:upper()
  end)
  return new_uri
end

local function lsp_navi_impl(err, result, ctx, orig_handlers)
  if err ~= nil or result == nil or vim.tbl_isempty(result) then
    return
  end

  -- Normalize the buffer name on Windows, so that other plugins (e.g. nvim-tree, telescope) can work better
  if nvim_util.is_win() then
    local uri_keys = { "targetUri", "uri" }
    for _, res_i in ipairs(result) do
      local uri_key = nil
      for _, key in ipairs(uri_keys) do
        if res_i[key] ~= nil then
          uri_key = key
          break
        end
      end
      if uri_key ~= nil then
        res_i[uri_key] = win_norm_uri(res_i[uri_key])
      end
    end
  end
  orig_handlers[ctx.method](err, result, ctx)
end

local function lsp_navi_handler(orig_navi_handlers)
  return function(err, result, ctx)
    lsp_navi_impl(err, result, ctx, orig_navi_handlers)
  end
end

M.setup = function()
  local config = {
    virtual_text = false,
    signs = {
      active = true,
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.INFO] = "",
        [vim.diagnostic.severity.HINT] = "",
      },
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })

  local navi_methods = {
    "textDocument/declaration",
    "textDocument/definition",
    "textDocument/implementation",
    "textDocument/references",
  }
  local orig_navi_handlers = {}
  for _, method in ipairs(navi_methods) do
    orig_navi_handlers[method] = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = lsp_navi_handler(orig_navi_handlers)
  end
end

return M
