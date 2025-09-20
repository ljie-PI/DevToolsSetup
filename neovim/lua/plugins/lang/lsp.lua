local M = {}

local lspconfig_util = require("lspconfig.util")

function M.setup()
  ----------------------------------------------------------------------------------------------------------------------
  -- Bash
  ----------------------------------------------------------------------------------------------------------------------
  vim.lsp.enable("bashls")

  ----------------------------------------------------------------------------------------------------------------------
  -- C/C++
  ----------------------------------------------------------------------------------------------------------------------
  vim.lsp.enable("clangd", {
    keys = {
      {
        "<leader>lh",
        "<cmd>ClangdSwitchSourceHeader<cr>",
        desc = "Switch Source/Header (C/C++)",
      },
    },
    root_dir = function(fname)
      local make_root = lspconfig_util.root_pattern(
        "Makefile",
        "configure.ac",
        "configure.in",
        "config.h.in",
        "meson.build",
        "meson_options.txt",
        "build.ninja"
      )(fname)
      local clang_root = lspconfig_util.root_pattern("compile_commands.json", "compile_flags.txt")(fname)
      local git_root = lspconfig_util.find_git_ancestor(fname)
      return make_root or clang_root or git_root
    end,
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
    },
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
  })

  ----------------------------------------------------------------------------------------------------------------------
  -- Go
  ----------------------------------------------------------------------------------------------------------------------
  vim.lsp.enable("gopls", {
    settings = {
      gopls = {
        gofumpt = true,
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        analyses = {
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
        semanticTokens = true,
      },
    },
  })

  ----------------------------------------------------------------------------------------------------------------------
  -- Lua
  ----------------------------------------------------------------------------------------------------------------------
  vim.lsp.enable("lua_ls", {
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
          version = "LuaJIT",
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            vim.fn.expand("$VIMRUNTIME/lua"),
            vim.fn.stdpath("config") .. "/lua",
          },
        },
      })
    end,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  })

  ----------------------------------------------------------------------------------------------------------------------
  -- Python
  ----------------------------------------------------------------------------------------------------------------------
  vim.lsp.enable("basedpyright", {
    settings = {
      basedpyright = {
        analysis = {
          typeCheckingMode = "standard",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "openFilesOnly", -- or "workspace"
        },
      },
    },
  })
  vim.lsp.enable("ruff", {
    cmd_env = { RUFF_TRACE = "messages" },
    init_options = {
      settings = {
        logLevel = "error",
      },
    },
  })

  ----------------------------------------------------------------------------------------------------------------------
  -- Rust
  ----------------------------------------------------------------------------------------------------------------------
  vim.lsp.enable("rust_analyzer")

  ----------------------------------------------------------------------------------------------------------------------
  -- Typescript
  ----------------------------------------------------------------------------------------------------------------------
  vim.lsp.enable("ts_ls", {
    init_options = {
      hostInfo = "neovim",
    },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    root_dir = lspconfig_util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
  })
end

return M
