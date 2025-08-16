-- Simple LSP Configuration for Go, Python, and Lua

return {
  -- Mason - LSP server manager
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end
  },

  -- Mason LSP Config
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",    -- Lua
          "gopls",     -- Go
          "pyright",   -- Python
        },
        automatic_installation = true,
      })
    end
  },

  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- Common on_attach function
      local on_attach = function(_, bufnr)  -- Using _ for unused client parameter
        local opts = { buffer = bufnr, silent = true }
        -- Key mappings
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)
        -- Diagnostics (using updated API)
---@diagnostic disable-next-line: deprecated
        vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, opts)
---@diagnostic disable-next-line: deprecated
        vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, opts)
      end

      -- Common capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- Configure diagnostics
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
      })

      -- Lua LSP (Enhanced configuration to fix vim global warnings)
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
              path = vim.split(package.path, ';')
            },
            diagnostics = {
              globals = { "vim", "use", "describe", "it", "assert" },  -- Add common globals
              disable = { "missing-fields", "incomplete-signature-doc" }
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
              },
              maxPreload = 100000,
              preloadFileSize = 10000,
              checkThirdParty = false,
            },
            telemetry = { enable = false },
            completion = {
              callSnippet = "Replace"
            },
            format = {
              enable = false -- Disable lua_ls formatting if you use other formatters
            }
          },
        },
      })

      -- Go LSP
      lspconfig.gopls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
          },
        },
      })

      -- Python LSP
      lspconfig.pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            }
          }
        }
      })
    end,
  }
}
