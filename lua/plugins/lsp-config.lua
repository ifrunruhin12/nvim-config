-- FINAL CLEAN LSP Configuration - Eliminates all duplicates and conflicts

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
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},

	-- Mason LSP Config - MINIMAL setup to prevent conflicts
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "gopls", "pyright" },
				automatic_installation = true,
				-- CRITICAL: Completely prevent mason from setting up ANY servers
				handlers = {
					function() end, -- Default handler does nothing
				},
			})
		end,
	},

	-- LSP Config - Clean manual setup
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Set diagnostic config ONCE globally
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
					source = "if_many",
					spacing = 2,
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
						[vim.diagnostic.severity.INFO] = " ",
					},
				},
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})

			-- Clean on_attach function
			local on_attach = function(client, bufnr)
				-- FORCE disable formatting for all LSP clients except null-ls
				if client.name ~= "null-ls" then
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end

				local opts = { buffer = bufnr, silent = true, noremap = true }

				-- Essential keymaps
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, opts)
				vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, opts)
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
			end

			-- Prevent multiple setups with a simpler approach
			local servers_started = {}

			local function start_server(name, config)
				if servers_started[name] then
					return
				end

				-- Kill any existing instances first
				local existing = vim.lsp.get_clients({ name = name })
				for _, client in pairs(existing) do
					client.stop()
				end

				-- Wait a moment for cleanup
				vim.defer_fn(function()
					lspconfig[name].setup(config)
					servers_started[name] = true
				end, 100)
			end

			-- Clean Lua LSP setup
			start_server("lua_ls", {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = {
							globals = { "vim", "use", "describe", "it", "assert", "before_each", "after_each" },
							disable = {
								"missing-fields",
								"incomplete-signature-doc",
								"inject-field",
								"undefined-field",
							},
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
							},
							checkThirdParty = false,
						},
						telemetry = { enable = false },
						completion = { callSnippet = "Replace" },
						format = { enable = false },
					},
				},
			})

			-- ULTRA CLEAN Go LSP setup - removed ALL formatting config to prevent conflicts
			start_server("gopls", {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					gopls = {
						-- MINIMAL settings to prevent conflicts
						completeUnimported = true,
						usePlaceholders = true,
						analyses = {
							unusedparams = true,
							shadow = true,
						},
						staticcheck = true,
						codelenses = {
							generate = true,
							test = true,
							tidy = true,
						},
						-- REMOVED all formatting-related settings to prevent "duplicate value" errors
					},
				},
				-- Force disable formatting capabilities
				on_init = function(client, _)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end,
			})

			-- Clean Python LSP setup
			start_server("pyright", {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
							typeCheckingMode = "basic",
						},
					},
				},
			})

			-- Monitor and clean up any duplicate instances
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then
						return
					end

					-- Check for duplicates and kill extras
					vim.defer_fn(function()
						local same_clients = vim.lsp.get_clients({ name = client.name })
						if #same_clients > 1 then
							-- Keep the newest one, kill older ones
							table.sort(same_clients, function(a, b)
								return a.id > b.id
							end)
							for i = 2, #same_clients do
								same_clients[i].stop()
							end
						end
					end, 500)
				end,
			})

			-- Improved cleanup command
			vim.api.nvim_create_user_command("FixLSP", function()
				-- Stop all LSP clients
				for _, client in pairs(vim.lsp.get_clients()) do
					client.stop()
				end

				-- Reset tracking
				servers_started = {}

				-- Restart after a moment
				vim.defer_fn(function()
					vim.cmd("edit") -- Reload current buffer to restart LSP
				end, 1000)

				vim.notify("LSP clients restarted", vim.log.levels.INFO)
			end, {})
		end,
	},
}
