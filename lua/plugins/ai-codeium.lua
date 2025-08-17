-- AI Assistant plugins for intelligent code suggestions and chat
-- Add these files to your lua/plugins/ directory

-- =============================================================================
-- File: lua/plugins/ai-codeium.lua
-- Codeium for intelligent code suggestions
-- =============================================================================
return {
	"Exafunction/codeium.vim",
	event = "InsertEnter",
	config = function()
		-- Disable codeium by default (can be enabled with <leader>ai)
		vim.g.codeium_enabled = false

		-- Set up keymaps
		vim.keymap.set("i", "<C-g>", function()
			return vim.fn["codeium#Accept"]()
		end, { expr = true, silent = true, desc = "Accept Codeium suggestion" })

		vim.keymap.set("i", "<C-;>", function()
			return vim.fn["codeium#CycleCompletions"](1)
		end, { expr = true, silent = true, desc = "Next Codeium suggestion" })

		vim.keymap.set("i", "<C-,>", function()
			return vim.fn["codeium#CycleCompletions"](-1)
		end, { expr = true, silent = true, desc = "Previous Codeium suggestion" })

		vim.keymap.set("i", "<C-x>", function()
			return vim.fn["codeium#Clear"]()
		end, { expr = true, silent = true, desc = "Clear Codeium suggestion" })

		-- Toggle Codeium on/off
		vim.keymap.set("n", "<leader>ai", function()
			if vim.g.codeium_enabled == false then
				vim.cmd("CodeiumEnable")
				vim.g.codeium_enabled = true
				vim.notify("🤖 Codeium AI enabled", vim.log.levels.INFO)
			else
				vim.notify("🤖 Codeium AI is already enabled", vim.log.levels.WARN)
			end
		end, { desc = "Enable Codeium AI" })

		vim.keymap.set("n", "<leader>dai", function()
			if vim.g.codeium_enabled == true then
				vim.cmd("CodeiumDisable")
				vim.g.codeium_enabled = false
				vim.notify("🚫 Codeium AI disabled", vim.log.levels.INFO)
			else
				vim.notify("🚫 Codeium AI is already disabled", vim.log.levels.WARN)
			end
		end, { desc = "Disable Codeium AI" })

		-- Status function for lualine
		_G.codeium_status = function()
			if vim.g.codeium_enabled == false then
				return "🤖❌"
			else
				return "🤖✅"
			end
		end

		-- Auto-commands for better UX
		vim.api.nvim_create_autocmd("InsertEnter", {
			callback = function()
				if vim.g.codeium_enabled then
					vim.notify("💡 Press Ctrl+G to accept AI suggestions", vim.log.levels.INFO, { timeout = 1000 })
				end
			end,
			once = false,
		})
	end,
}
