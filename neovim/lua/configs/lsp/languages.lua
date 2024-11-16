local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

------------------------------------------------------------------------------------------------------------------------
-- Lua
------------------------------------------------------------------------------------------------------------------------
lspconfig.lua_ls.setup {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT"
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          vim.fn.expand("$VIMRUNTIME/lua"),
          vim.fn.stdpath("config") .. "/lua"
        }
      }
    })
  end,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      }
    },
  },
}


------------------------------------------------------------------------------------------------------------------------
-- C/C++
------------------------------------------------------------------------------------------------------------------------
lspconfig.clangd.setup {}


------------------------------------------------------------------------------------------------------------------------
-- Rust
------------------------------------------------------------------------------------------------------------------------
lspconfig.rust_analyzer.setup {}


------------------------------------------------------------------------------------------------------------------------
-- Bash
------------------------------------------------------------------------------------------------------------------------
lspconfig.bashls.setup {}


------------------------------------------------------------------------------------------------------------------------
-- Python
------------------------------------------------------------------------------------------------------------------------
lspconfig.pylsp.setup {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { "W391" },
          maxLineLength = 100
        }
      }
    }
  }
}


------------------------------------------------------------------------------------------------------------------------
-- Typescript/Javascript
------------------------------------------------------------------------------------------------------------------------
lspconfig.ts_ls.setup {
  init_options = {
    hostInfo = "neovim"
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx"
  },
  root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json")
}
