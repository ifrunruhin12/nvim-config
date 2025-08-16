-- nvim-cmp configuration for autocompletion and snippets
-- This provides intelligent autocompletion with LSP integration

return {
	-- Main completion engine
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet engine
			{
				"L3MON4D3/LuaSnip",
				build = "make install_jsregexp", -- Optional jsregexp support
				dependencies = {
					"rafamadriz/friendly-snippets", -- Collection of snippets
				},
			},
			-- Completion sources
			"hrsh7th/cmp-nvim-lsp", -- LSP completions
			"hrsh7th/cmp-buffer", -- Buffer completions
			"hrsh7th/cmp-path", -- File path completions
			"hrsh7th/cmp-cmdline", -- Command line completions
			"saadparwaiz1/cmp_luasnip", -- Snippet completions
			"hrsh7th/cmp-nvim-lua", -- Neovim Lua API completions
			-- Icons for completion menu
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			-- Load snippets from friendly-snippets
			require("luasnip.loaders.from_vscode").lazy_load()

			-- Load custom snippets
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" })

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				window = {
					completion = cmp.config.window.bordered({
						border = "rounded",
						winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
					}),
					documentation = cmp.config.window.bordered({
						border = "rounded",
						winhighlight = "Normal:CmpPmenu",
					}),
				},

				mapping = cmp.mapping.preset.insert({
					-- Navigate completion menu
					["<C-k>"] = cmp.mapping.select_prev_item(), -- Previous item
					["<C-j>"] = cmp.mapping.select_next_item(), -- Next item
					["<Up>"] = cmp.mapping.select_prev_item(), -- Arrow up
					["<Down>"] = cmp.mapping.select_next_item(), -- Arrow down
					["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll docs up
					["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll docs down
					["<C-Space>"] = cmp.mapping.complete(), -- Show completion menu
					["<C-e>"] = cmp.mapping.abort(), -- Close completion menu

					-- Accept completion
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = false, -- Don't select first item automatically
					}),

					-- Tab completion with snippet support
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expandable() then
							luasnip.expand()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),

					-- Shift-Tab for reverse navigation
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),

				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 1000 }, -- LSP completions (highest priority)
					{ name = "luasnip", priority = 900 }, -- Snippet completions
					{ name = "nvim_lua", priority = 800 }, -- Neovim Lua API
					{ name = "buffer", priority = 700, keyword_length = 3 }, -- Buffer words
					{ name = "path", priority = 600 }, -- File paths
				}),

				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text", -- Show symbol and text
						maxwidth = 50, -- Prevent popup from being too wide
						ellipsis_char = "...", -- Truncation character
						show_labelDetails = true, -- Show extra details

						-- Custom icons for different sources
						before = function(entry, vim_item)
							-- Source indicators
							vim_item.menu = ({
								nvim_lsp = "[LSP]",
								luasnip = "[Snip]",
								buffer = "[Buf]",
								path = "[Path]",
								nvim_lua = "[Lua]",
							})[entry.source.name]
							return vim_item
						end,
					}),
				},

				experimental = {
					ghost_text = true, -- Show ghost text preview
				},

				-- Completion behavior
				completion = {
					completeopt = "menu,menuone,noinsert", -- Don't auto-insert, show menu always
				},
			})

			-- Command-line completion
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
				matching = { disallow_symbol_nonprefix_matching = false },
			})

			-- Search completion
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Snippet navigation keymaps (outside insert mode)
			vim.keymap.set({ "i", "s" }, "<C-l>", function()
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				end
			end, { silent = true, desc = "Expand or jump forward in snippet" })

			vim.keymap.set({ "i", "s" }, "<C-h>", function()
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				end
			end, { silent = true, desc = "Jump backward in snippet" })

			-- Snippet choice selection
			vim.keymap.set("i", "<C-E>", function()
				if luasnip.choice_active() then
					luasnip.change_choice(1)
				end
			end, { silent = true, desc = "Cycle through snippet choices" })
		end,
	},

	-- Additional completion sources
	{
		"hrsh7th/cmp-buffer",
		event = "InsertEnter",
	},
	{
		"hrsh7th/cmp-path",
		event = "InsertEnter",
	},
	{
		"hrsh7th/cmp-cmdline",
		event = "CmdlineEnter",
	},
	{
		"saadparwaiz1/cmp_luasnip",
		event = "InsertEnter",
	},
	{
		"hrsh7th/cmp-nvim-lua",
		event = "InsertEnter",
	},
	{
		"onsails/lspkind.nvim",
		event = "InsertEnter",
	},
}
