-- None-ls configuration for formatting and linting
-- Fixed to prevent duplicate formatting and ensure single source of truth

return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"williamboman/mason.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		-- FIXED: Create a single augroup for formatting to prevent duplicates
		local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

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
				--null_ls.builtins.diagnostics.flake8,

				-- JavaScript/TypeScript formatting
				null_ls.builtins.formatting.prettier.with({
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"vue",
						"css",
						"scss",
						"less",
						"html",
						"json",
						"jsonc",
						"yaml",
						"markdown",
						"graphql",
						"handlebars",
					},
				}),

				-- Ruby rails formatting
				null_ls.builtins.diagnostics.rubocop,
				null_ls.builtins.formatting.rubocop,

				-- Shell formatting and linting
				null_ls.builtins.formatting.shfmt,
				-- null_ls.builtins.diagnostics.shellcheck,

				-- General purpose
				null_ls.builtins.diagnostics.codespell,
				null_ls.builtins.code_actions.gitsigns,
			},

			-- FIXED: Format on save with proper client checking
			on_attach = function(client, bufnr)
				-- Only set up formatting if this client supports it
				if client.supports_method("textDocument/formatting") then
					-- Clear any existing autocmds for this buffer
					vim.api.nvim_clear_autocmds({
						group = augroup,
						buffer = bufnr,
					})

					-- Create format on save autocmd
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							-- FIXED: Only format with none-ls, not all LSP clients
							vim.lsp.buf.format({
								async = false,
								filter = function(format_client)
									-- Only use none-ls for formatting to avoid conflicts
									return format_client.name == "null-ls"
								end,
							})
						end,
					})
				end
			end,

			-- FIXED: Reduce diagnostic update frequency to prevent duplicates
			update_in_insert = false,
			debounce = 300,
		})

		-- FIXED: Manual formatting keymap that only uses none-ls
		vim.keymap.set("n", "<leader>f", function()
			vim.lsp.buf.format({
				async = true,
				filter = function(client)
					-- Only use none-ls for manual formatting too
					return client.name == "null-ls"
				end,
			})
		end, { desc = "Format current file (none-ls only)" })

		-- Key mapping for code actions (unchanged)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
	end,
}
