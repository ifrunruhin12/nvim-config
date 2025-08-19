return {
	"jackMort/ChatGPT.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("chatgpt").setup({
			api_key_cmd = nil, -- You'll need to set OPENAI_API_KEY environment variable
			yank_register = "+",
			edit_with_instructions = {
				diff = false,
				keymaps = {
					close = "<C-c>",
					accept = "<C-y>",
					toggle_diff = "<C-d>",
					toggle_settings = "<C-o>",
					toggle_help = "<C-h>",
					cycle_windows = "<Tab>",
					use_output_as_input = "<C-i>",
				},
			},
			chat = {
				welcome_message = "🤖 Welcome to ChatGPT! Ask me anything about your code.",
				loading_text = "Loading, please wait ...",
				question_sign = "🧑",
				answer_sign = "🤖",
				border_left_sign = "│",
				border_right_sign = "│",
				max_line_length = 120,
				sessions_window = {
					active_sign = "  ",
					inactive_sign = "  ",
					current_line_sign = "",
					border = {
						style = "rounded",
						text = {
							top = " Sessions ",
						},
					},
					win_options = {
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
					},
				},
				keymaps = {
					close = "<C-c>",
					yank_last = "<C-y>",
					yank_last_code = "<C-k>",
					scroll_up = "<C-u>",
					scroll_down = "<C-d>",
					new_session = "<C-n>",
					cycle_windows = "<Tab>",
					cycle_modes = "<C-f>",
					next_message = "<C-j>",
					prev_message = "<C-k>",
					select_session = "<Space>",
					rename_session = "r",
					delete_session = "d",
					draft_message = "<C-r>",
					edit_message = "e",
					delete_message = "d",
					toggle_settings = "<C-o>",
					toggle_sessions = "<C-p>",
					toggle_help = "<C-h>",
					toggle_message_role = "<C-r>",
					toggle_system_role_open = "<C-s>",
					stop_generating = "<C-x>",
				},
			},
			popup_layout = {
				default = "center",
				center = {
					width = "80%",
					height = "80%",
				},
				right = {
					width = "30%",
					width_settings_open = "50%",
				},
			},
			popup_window = {
				border = {
					highlight = "FloatBorder",
					style = "rounded",
					text = {
						top = " ChatGPT ",
					},
				},
				win_options = {
					wrap = true,
					linebreak = true,
					foldcolumn = "1",
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
				},
				buf_options = {
					filetype = "markdown",
				},
			},
			system_window = {
				border = {
					highlight = "FloatBorder",
					style = "rounded",
					text = {
						top = " SYSTEM ",
					},
				},
				win_options = {
					wrap = true,
					linebreak = true,
					foldcolumn = "2",
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
				},
			},
			popup_input = {
				prompt = "  ",
				border = {
					highlight = "FloatBorder",
					style = "rounded",
					text = {
						top_align = "center",
						top = " Prompt ",
					},
				},
				win_options = {
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
				},
				submit = "<C-Enter>",
				submit_n = "<Enter>",
				max_visible_lines = 20,
			},
			settings_window = {
				setting_sign = "  ",
				border = {
					style = "rounded",
					text = {
						top = " Settings ",
					},
				},
				win_options = {
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
				},
			},
			help_window = {
				setting_sign = "  ",
				border = {
					style = "rounded",
					text = {
						top = " Help ",
					},
				},
				win_options = {
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
				},
			},
			openai_params = {
				model = "gpt-3.5-turbo",
				frequency_penalty = 0,
				presence_penalty = 0,
				max_tokens = 300,
				temperature = 0,
				top_p = 1,
				n = 1,
			},
			openai_edit_params = {
				model = "gpt-3.5-turbo",
				frequency_penalty = 0,
				presence_penalty = 0,
				temperature = 0,
				top_p = 1,
				n = 1,
			},
			use_openai_functions_for_edits = false,
			actions_paths = {},
			show_quickfixes_cmd = "Trouble quickfix",
			predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
			highlights = {
				help_key = "@symbol",
				help_description = "@comment",
			},
		})

		-- Key mappings for ChatGPT
		local opts = { noremap = true, silent = true }

		-- Chat commands
		vim.keymap.set("n", "<leader>cc", "<cmd>ChatGPT<CR>", vim.tbl_extend("force", opts, { desc = "Open ChatGPT" }))
		vim.keymap.set(
			"n",
			"<leader>ce",
			"<cmd>ChatGPTEditWithInstruction<CR>",
			vim.tbl_extend("force", opts, { desc = "Edit with instruction" })
		)
		vim.keymap.set(
			"v",
			"<leader>ce",
			"<cmd>ChatGPTEditWithInstruction<CR>",
			vim.tbl_extend("force", opts, { desc = "Edit selection with instruction" })
		)

		-- Code actions
		vim.keymap.set(
			"n",
			"<leader>cg",
			"<cmd>ChatGPTRun grammar_correction<CR>",
			vim.tbl_extend("force", opts, { desc = "Grammar correction" })
		)
		vim.keymap.set(
			"n",
			"<leader>ct",
			"<cmd>ChatGPTRun translate<CR>",
			vim.tbl_extend("force", opts, { desc = "Translate" })
		)
		vim.keymap.set(
			"n",
			"<leader>ck",
			"<cmd>ChatGPTRun keywords<CR>",
			vim.tbl_extend("force", opts, { desc = "Keywords" })
		)
		vim.keymap.set(
			"n",
			"<leader>cd",
			"<cmd>ChatGPTRun docstring<CR>",
			vim.tbl_extend("force", opts, { desc = "Generate docstring" })
		)
		vim.keymap.set(
			"n",
			"<leader>cga",
			"<cmd>ChatGPTRun add_tests<CR>",
			vim.tbl_extend("force", opts, { desc = "Add tests" })
		)
		vim.keymap.set(
			"n",
			"<leader>co",
			"<cmd>ChatGPTRun optimize_code<CR>",
			vim.tbl_extend("force", opts, { desc = "Optimize code" })
		)
		vim.keymap.set(
			"n",
			"<leader>cs",
			"<cmd>ChatGPTRun summarize<CR>",
			vim.tbl_extend("force", opts, { desc = "Summarize" })
		)
		vim.keymap.set(
			"n",
			"<leader>cf",
			"<cmd>ChatGPTRun fix_bugs<CR>",
			vim.tbl_extend("force", opts, { desc = "Fix bugs" })
		)
		vim.keymap.set(
			"n",
			"<leader>cx",
			"<cmd>ChatGPTRun explain_code<CR>",
			vim.tbl_extend("force", opts, { desc = "Explain code" })
		)
		vim.keymap.set(
			"n",
			"<leader>cr",
			"<cmd>ChatGPTRun roxygen_edit<CR>",
			vim.tbl_extend("force", opts, { desc = "Roxygen edit" })
		)
		vim.keymap.set(
			"n",
			"<leader>cl",
			"<cmd>ChatGPTRun code_readability_analysis<CR>",
			vim.tbl_extend("force", opts, { desc = "Code readability analysis" })
		)

		-- Visual mode mappings
		vim.keymap.set(
			"v",
			"<leader>ce",
			"<cmd>ChatGPTEditWithInstruction<CR>",
			vim.tbl_extend("force", opts, { desc = "Edit with instruction" })
		)
		vim.keymap.set(
			"v",
			"<leader>cg",
			"<cmd>ChatGPTRun grammar_correction<CR>",
			vim.tbl_extend("force", opts, { desc = "Grammar correction" })
		)
		vim.keymap.set(
			"v",
			"<leader>ct",
			"<cmd>ChatGPTRun translate<CR>",
			vim.tbl_extend("force", opts, { desc = "Translate" })
		)
		vim.keymap.set(
			"v",
			"<leader>ck",
			"<cmd>ChatGPTRun keywords<CR>",
			vim.tbl_extend("force", opts, { desc = "Keywords" })
		)
		vim.keymap.set(
			"v",
			"<leader>cd",
			"<cmd>ChatGPTRun docstring<CR>",
			vim.tbl_extend("force", opts, { desc = "Generate docstring" })
		)
		vim.keymap.set(
			"v",
			"<leader>c,",
			"<cmd>ChatGPTRun add_tests<CR>",
			vim.tbl_extend("force", opts, { desc = "Add tests" })
		)
		vim.keymap.set(
			"v",
			"<leader>co",
			"<cmd>ChatGPTRun optimize_code<CR>",
			vim.tbl_extend("force", opts, { desc = "Optimize code" })
		)
		vim.keymap.set(
			"v",
			"<leader>cs",
			"<cmd>ChatGPTRun summarize<CR>",
			vim.tbl_extend("force", opts, { desc = "Summarize" })
		)
		vim.keymap.set(
			"v",
			"<leader>cf",
			"<cmd>ChatGPTRun fix_bugs<CR>",
			vim.tbl_extend("force", opts, { desc = "Fix bugs" })
		)
		vim.keymap.set(
			"v",
			"<leader>cx",
			"<cmd>ChatGPTRun explain_code<CR>",
			vim.tbl_extend("force", opts, { desc = "Explain code" })
		)
		vim.keymap.set(
			"v",
			"<leader>cr",
			"<cmd>ChatGPTRun roxygen_edit<CR>",
			vim.tbl_extend("force", opts, { desc = "Roxygen edit" })
		)
		vim.keymap.set(
			"v",
			"<leader>cl",
			"<cmd>ChatGPTRun code_readability_analysis<CR>",
			vim.tbl_extend("force", opts, { desc = "Code readability analysis" })
		)

		-- Quick access to most used features
		vim.keymap.set("n", "<leader>ch", function()
			vim.notify(
				"🤖 ChatGPT Commands:\n<leader>cc - Chat\n<leader>ce - Edit with instruction\n<leader>cx - Explain code\n<leader>co - Optimize code\n<leader>cf - Fix bugs",
				vim.log.levels.INFO
			)
		end, vim.tbl_extend("force", opts, { desc = "Show ChatGPT help" }))
	end,
}
