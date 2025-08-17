-- =============================================================================
-- File: lua/plugins/ai-gen.lua
-- Gen.nvim for AI code generation and actions
-- =============================================================================

return {
	"David-Kunz/gen.nvim",
	event = "VeryLazy",
	config = function()
		require("gen").setup({
			model = "codellama:7b", -- The default model to use (you can change this)
			quit_map = "q", -- set keymap for close the response window
			retry_map = "<c-r>", -- set keymap to re-send the current prompt
			accept_map = "<c-cr>", -- set keymap to replace the previous selection with the last result
			host = "localhost", -- The host running the Ollama service
			port = "11434", -- The port on which the Ollama service is listening
			display_mode = "float", -- The display mode. Can be "float" or "split" or "horizontal-split"
			show_prompt = false, -- Shows the prompt submitted to Ollama
			show_model = false, -- Displays which model you are using at the beginning of your chat session
			no_auto_close = false, -- Never closes the window automatically
			debug = false, -- Prints errors and the command which is run
			init = function(options)
				pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
			end,
			-- Function to initialize Ollama
			command = function(options)
				local body = { model = options.model, stream = true }
				return "curl --silent --no-buffer -X POST http://"
					.. options.host
					.. ":"
					.. options.port
					.. "/api/chat -d $body"
			end,
		})

		-- Custom prompts for development
		require("gen").prompts["Explain_Code"] = {
			prompt = "Explain the following code:\n$text",
			replace = false,
		}

		require("gen").prompts["Fix_Code"] = {
			prompt = "Fix the following code. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
			replace = true,
			extract = "```$filetype\n(.-)```",
		}

		require("gen").prompts["Optimize_Code"] = {
			prompt = "Optimize the following code. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
			replace = true,
			extract = "```$filetype\n(.-)```",
		}

		require("gen").prompts["Add_Comments"] = {
			prompt = "Add comments to the following code. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
			replace = true,
			extract = "```$filetype\n(.-)```",
		}

		require("gen").prompts["Generate_Tests"] = {
			prompt = "Generate unit tests for the following code:\n```$filetype\n$text\n```",
			replace = false,
		}

		-- Key mappings for Gen.nvim
		vim.keymap.set({ "n", "v" }, "<leader>]", ":Gen<CR>")
		vim.keymap.set({ "n", "v" }, "<leader>ge", ":Gen Explain_Code<CR>", { desc = "Explain code" })
		vim.keymap.set({ "n", "v" }, "<leader>gf", ":Gen Fix_Code<CR>", { desc = "Fix code" })
		vim.keymap.set({ "n", "v" }, "<leader>go", ":Gen Optimize_Code<CR>", { desc = "Optimize code" })
		vim.keymap.set({ "n", "v" }, "<leader>gc", ":Gen Add_Comments<CR>", { desc = "Add comments" })
		vim.keymap.set({ "n", "v" }, "<leader>gt", ":Gen Generate_Tests<CR>", { desc = "Generate tests" })
	end,
}
