local M = {}

local function is_windows()
  return vim.fn.has("win32") == 1 or vim.fn.has("win32unix") == 1
end

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
  if is_windows then
    local uri_key = "targetUri"
    if ctx.method == "textDocument/references" then
      uri_key = "uri"
    end
    for _, res_i in ipairs(result) do
      res_i[uri_key] = win_norm_uri(res_i[uri_key])
    end
  end
  orig_handlers[ctx.method](err, result, ctx)
end

local function lsp_navi_handler(orig_navi_handlers)
  return function(err, result, ctx)
    lsp_navi_impl(err, result, ctx, orig_navi_handlers)
  end
end

-- TODO: backfill this to template
M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
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
    "textDocument/references"
  }
  local orig_navi_handlers = {}
  for _, method in ipairs(navi_methods) do
    orig_navi_handlers[method] = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = lsp_navi_handler(orig_navi_handlers)
  end
end

-- local function lsp_highlight_document(client)
--   -- Set autocommands conditional on server_capabilities
--   if client.server_capabilities.documentHighlight then
--     vim.api.nvim_exec(
--       [[
--       augroup lsp_document_highlight
--         autocmd! * <buffer>
--         autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--         autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--       augroup END
--     ]],
--       false
--     )
--   end
-- end

-- M.on_attach = function(client, bufnr)
--   lsp_highlight_document(client)
-- end

-- local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
-- if status_ok then
--   M.capabilities = cmp_nvim_lsp.default_capabilities()
-- end

return M
