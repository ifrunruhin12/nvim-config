-- Auto-pairs configuration for automatic bracket/parenthesis completion
-- Place this file at: lua/plugins/autopairs.lua

return {
	"windwp/nvim-autopairs",
	event = "InsertEnter", -- Load only when entering insert mode
	dependencies = { "hrsh7th/nvim-cmp" }, -- Optional integration with nvim-cmp
	config = function()
		local autopairs = require("nvim-autopairs")

		autopairs.setup({
			-- Basic autopairs options
			check_ts = true, -- Use treesitter for better pair detection
			ts_config = {
				lua = { "string", "source" },
				javascript = { "string", "template_string" },
				java = false, -- Don't check treesitter on java
			},

			-- Don't add pairs if it already has a close pair
			disable_filetype = { "TelescopePrompt", "spectre_panel" },
			disable_in_macro = true, -- Disable when recording or executing a macro
			disable_in_visualblock = false, -- Disable when selecting in visual block mode
			disable_in_replace_mode = true,
			ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],

			-- Enable nvim-cmp integration
			enable_moveright = true,
			enable_afterquote = true, -- Add bracket pairs after quote
			enable_check_bracket_line = true, -- Don't add pair if next char is a close pair
			enable_bracket_in_quote = true, -- Add bracket pairs in quotes
			enable_abbr = false, -- Trigger abbreviation
			break_undo = true, -- Switch for basic rule break undo sequence

			-- Map keys
			map_bs = true, -- Map the <BS> key
			map_c_h = false, -- Map the <C-h> key to delete a pair
			map_c_w = false, -- Map <c-w> to delete a pair if possible

			-- Advanced features
			check_comma = true,
			move_end_when_closing = true,
		})

		-- Integration with nvim-cmp for better completion experience
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")

		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

		-- Custom rules for specific cases
		local Rule = require("nvim-autopairs.rule")
		local ts_conds = require("nvim-autopairs.ts-conds")

		-- Add spaces inside parentheses for function calls (optional)
		-- autopairs.add_rules({
		--   Rule(" ", " ")
		--     :with_pair(function(opts)
		--       local pair = opts.line:sub(opts.col - 1, opts.col)
		--       return vim.tbl_contains({ "()", "[]", "{}" }, pair)
		--     end),
		--   Rule("( ", " )")
		--     :with_pair(function() return false end)
		--     :with_move(function(opts)
		--       return opts.prev_char:match(".%)") ~= nil
		--     end)
		--     :use_key(")"),
		--   Rule("{ ", " }")
		--     :with_pair(function() return false end)
		--     :with_move(function(opts)
		--       return opts.prev_char:match(".%}") ~= nil
		--     end)
		--     :use_key("}"),
		--   Rule("[ ", " ]")
		--     :with_pair(function() return false end)
		--     :with_move(function(opts)
		--       return opts.prev_char:match(".%]") ~= nil
		--     end)
		--     :use_key("]")
		-- })

		-- Language-specific rules

		-- HTML/JSX
		autopairs.add_rules({
			Rule("<!--", "-->", "html"),
			Rule("<%", "%>", { "eruby", "erb" }),
		})

		-- Lua specific rules
		autopairs.add_rules({
			Rule("then", "end", "lua"):end_wise(true):with_cr(ts_conds.is_ts_node("if_statement")),
			Rule("function", "end", "lua"):end_wise(true):with_cr(ts_conds.is_ts_node("function_declaration")),
		})

		-- Go specific rules
		autopairs.add_rules({
			Rule("/*", "*/", "go"),
		})

		-- Python specific rules
		autopairs.add_rules({
			Rule('"""', '"""', "python"),
			Rule("'''", "'''", "python"),
		})

		-- Additional keymaps for advanced functionality
		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }

		-- Toggle autopairs on/off
		map("n", "<leader>ap", function()
			local disabled = not require("nvim-autopairs").state.disabled
			require("nvim-autopairs").disable()
			if not disabled then
				require("nvim-autopairs").enable()
				vim.notify("Autopairs enabled", vim.log.levels.INFO)
			else
				vim.notify("Autopairs disabled", vim.log.levels.INFO)
			end
		end, { desc = "Toggle autopairs" })
	end,
}
