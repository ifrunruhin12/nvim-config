-- GitHub Copilot - Much more reliable than Codeium
-- Create this as lua/plugins/ai-copilot.lua
-- Then comment out or remove your Codeium plugin

return {
	"github/copilot.vim",
	event = "InsertEnter",
	config = function()
		-- Disable default tab mapping to avoid conflicts
		vim.g.copilot_no_tab_map = true
		vim.g.copilot_assume_mapped = true

		-- Enable for specific filetypes
		vim.g.copilot_filetypes = {
			["*"] = true, -- Enable for all files by default
			["gitcommit"] = false,
			["gitrebase"] = false,
			["hgcommit"] = false,
			["svn"] = false,
			["cvs"] = false,
			["."] = false,
		}

		-- Keymaps (same as your Codeium ones)
		vim.keymap.set("i", "<C-g>", 'copilot#Accept("\\<CR>")', {
			expr = true,
			replace_keycodes = false,
			desc = "Accept Copilot suggestion",
		})

		vim.keymap.set("i", "<C-;>", "<Plug>(copilot-next)", { desc = "Next Copilot suggestion" })
		vim.keymap.set("i", "<C-,>", "<Plug>(copilot-previous)", { desc = "Previous Copilot suggestion" })
		vim.keymap.set("i", "<C-x>", "<Plug>(copilot-dismiss)", { desc = "Dismiss Copilot suggestion" })

		-- Tab integration with nvim-cmp
		vim.keymap.set("i", "<Tab>", function()
			local cmp = require("cmp")
			if cmp.visible() then
				return cmp.confirm({ select = true })
			end

			-- Check for copilot suggestion
			if vim.fn["copilot#GetDisplayedSuggestion"]().text ~= "" then
				return vim.fn["copilot#Accept"]("\\<CR>")
			end

			return "<Tab>"
		end, { expr = true, silent = true, desc = "Accept completion or tab" })

		-- Control commands (same shortcuts as Codeium)
		vim.keymap.set("n", "<leader>ai", function()
			vim.cmd("Copilot enable")
			vim.notify("🤖 GitHub Copilot enabled", vim.log.levels.INFO)
		end, { desc = "Enable GitHub Copilot" })

		vim.keymap.set("n", "<leader>dai", function()
			vim.cmd("Copilot disable")
			vim.notify("🚫 GitHub Copilot disabled", vim.log.levels.INFO)
		end, { desc = "Disable GitHub Copilot" })

		vim.keymap.set("n", "<leader>tai", function()
			vim.cmd("Copilot toggle")
			vim.notify("🔄 GitHub Copilot toggled", vim.log.levels.INFO)
		end, { desc = "Toggle GitHub Copilot" })

		-- Status and auth
		vim.keymap.set("n", "<leader>cis", function()
			vim.cmd("Copilot status")
		end, { desc = "Check Copilot status" })

		vim.keymap.set("n", "<leader>cia", function()
			vim.cmd("Copilot setup")
		end, { desc = "Setup GitHub Copilot" })

		-- Panel commands
		vim.keymap.set("n", "<leader>cp", function()
			vim.cmd("Copilot panel")
		end, { desc = "Open Copilot panel" })

		-- Status function for lualine (replaces Codeium one)
		_G.codeium_status = function()
			local status = vim.fn["copilot#Enabled"]()
			if status == 1 then
				return "🤖✅"
			else
				return "🤖❌"
			end
		end

		-- Welcome message
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				vim.defer_fn(function()
					vim.notify("🤖 GitHub Copilot loaded! Use :Copilot setup to authenticate", vim.log.levels.INFO)
				end, 1000)
			end,
			once = true,
		})

		-- Insert mode notification
		vim.api.nvim_create_autocmd("InsertEnter", {
			callback = function()
				if vim.fn["copilot#Enabled"]() == 1 then
					vim.defer_fn(function()
						vim.notify("💡 Copilot active - Ctrl+G to accept", vim.log.levels.INFO, { timeout = 1500 })
					end, 500)
				end
			end,
			once = false,
		})
	end,
}
