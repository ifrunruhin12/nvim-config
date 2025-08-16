-- None-ls configuration for formatting and linting
-- None-ls is the community fork of null-ls

return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "williamboman/mason.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    -- Create augroup for formatting
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    -- Configure none-ls
    null_ls.setup({
      sources = {
        -- Lua formatting
        null_ls.builtins.formatting.stylua,

        -- Go formatting and imports
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.formatting.gofmt,

        -- Python formatting and linting
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.diagnostics.flake8,

        -- JavaScript/TypeScript formatting
        null_ls.builtins.formatting.prettier.with({
          filetypes = {
            "javascript", "javascriptreact", "typescript", "typescriptreact",
            "vue", "css", "scss", "less", "html", "json", "jsonc", "yaml",
            "markdown", "graphql", "handlebars"
          },
        }),

        -- Ruby rails formatting
        null_ls.builtins.diagnostics.rubocop,
        null_ls.builtins.formatting.rubocop,

        -- Shell formatting and linting
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.diagnostics.shellcheck,

        -- General purpose
        null_ls.builtins.diagnostics.codespell, -- Spell checker
        null_ls.builtins.code_actions.gitsigns,  -- Git actions (if you add gitsigns)
      },

      -- Format on save (optional - you can disable this if you prefer manual formatting)
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end,
    })

    -- Key mappings for manual formatting
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, { desc = "Format current file" })

    -- Key mapping for code actions
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
  end,
}
