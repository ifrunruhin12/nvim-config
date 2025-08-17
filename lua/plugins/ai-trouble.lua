-- =============================================================================
-- File: lua/plugins/ai-trouble.lua
-- Trouble.nvim for better quickfix and diagnostics (dependency for ChatGPT)
-- =============================================================================
return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("trouble").setup({
			-- your configuration comes here
			-- or leave it empty to use the default settings
		})

		-- Key mappings
		vim.keymap.set("n", "<leader>xx", function()
			require("trouble").toggle()
		end, { desc = "Toggle Trouble" })
		vim.keymap.set("n", "<leader>xw", function()
			require("trouble").toggle("workspace_diagnostics")
		end, { desc = "Workspace diagnostics" })
		vim.keymap.set("n", "<leader>xd", function()
			require("trouble").toggle("document_diagnostics")
		end, { desc = "Document diagnostics" })
		vim.keymap.set("n", "<leader>xq", function()
			require("trouble").toggle("quickfix")
		end, { desc = "Quickfix" })
		vim.keymap.set("n", "<leader>xl", function()
			require("trouble").toggle("loclist")
		end, { desc = "Location list" })
		vim.keymap.set("n", "gR", function()
			require("trouble").toggle("lsp_references")
		end, { desc = "LSP references" })
	end,
}
