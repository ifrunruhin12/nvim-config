-- DAP (Debug Adapter Protocol) configuration for debugging
-- Comprehensive setup with Go debugging support, UI, and virtual text

return {
	-- Main DAP plugin
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			local dap = require("dap")

			-- DAP signs configuration
			vim.fn.sign_define("DapBreakpoint", {
				text = "🔴",
				texthl = "DapBreakpoint",
				linehl = "DapBreakpointLine",
				numhl = "DapBreakpoint",
			})
			vim.fn.sign_define("DapBreakpointCondition", {
				text = "🟡",
				texthl = "DapBreakpoint",
				linehl = "DapBreakpointLine",
				numhl = "DapBreakpoint",
			})
			vim.fn.sign_define("DapLogPoint", {
				text = "📝",
				texthl = "DapLogPoint",
				linehl = "DapLogPointLine",
				numhl = "DapLogPoint",
			})
			vim.fn.sign_define("DapStopped", {
				text = "▶️",
				texthl = "DapStopped",
				linehl = "DapStoppedLine",
				numhl = "DapStopped",
			})
			vim.fn.sign_define("DapBreakpointRejected", {
				text = "❌",
				texthl = "DapBreakpointRejected",
				linehl = "DapBreakpointRejectedLine",
				numhl = "DapBreakpointRejected",
			})

			-- Go debugging configuration (using Delve)
			dap.adapters.delve = {
				type = "server",
				port = "${port}",
				executable = {
					command = "dlv",
					args = { "dap", "-l", "127.0.0.1:${port}" },
				},
			}

			-- Go DAP configurations
			dap.configurations.go = {
				{
					type = "delve",
					name = "Debug",
					request = "launch",
					program = "${file}",
				},
				{
					type = "delve",
					name = "Debug (Arguments)",
					request = "launch",
					program = "${file}",
					args = function()
						local args_string = vim.fn.input("Arguments: ")
						return vim.split(args_string, " ", { plain = true })
					end,
				},
				{
					type = "delve",
					name = "Debug Package",
					request = "launch",
					program = "${fileDirname}",
				},
				{
					type = "delve",
					name = "Debug Test",
					request = "launch",
					mode = "test",
					program = "${file}",
				},
				{
					type = "delve",
					name = "Debug Test Package",
					request = "launch",
					mode = "test",
					program = "${fileDirname}",
				},
				{
					type = "delve",
					name = "Attach to Process",
					request = "attach",
					processId = function()
						return tonumber(vim.fn.input("Process ID: "))
					end,
				},
			}

			-- Essential DAP keymaps
			local opts = { noremap = true, silent = true }

			-- Debugging controls
			vim.keymap.set("n", "<F5>", dap.continue, { desc = "Continue debugging" })
			vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step over" })
			vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step into" })
			vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step out" })

			-- Breakpoint management
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Set conditional breakpoint" })
			vim.keymap.set("n", "<leader>lp", function()
				dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end, { desc = "Set log point" })

			-- Session management
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue debugging" })
			vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
			vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run last debug session" })
			vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate debugging" })

			-- Variables and frames
			vim.keymap.set("n", "<leader>dh", function()
				require("dap.ui.widgets").hover()
			end, { desc = "Hover variables" })
			vim.keymap.set("n", "<leader>dp", function()
				require("dap.ui.widgets").preview()
			end, { desc = "Preview variables" })
			vim.keymap.set("n", "<leader>df", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end, { desc = "Show frames" })
			vim.keymap.set("n", "<leader>ds", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end, { desc = "Show scopes" })

			-- Auto-open REPL when debugging starts
			dap.listeners.after.event_initialized["dapui_config"] = function()
				vim.notify("Debugger initialized", vim.log.levels.INFO)
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				vim.notify("Debugger terminated", vim.log.levels.INFO)
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				vim.notify("Debugger exited", vim.log.levels.INFO)
			end
		end,
	},

	-- Mason DAP integration for automatic adapter installation
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = {
					"delve", -- Go debugger
				},
				automatic_installation = true,
				handlers = {
					function(config)
						-- Default handler - applies to all sources
						require("mason-nvim-dap").default_setup(config)
					end,
				},
			})
		end,
	},

	-- DAP UI for better debugging experience
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- DAP UI setup
			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
				mappings = {
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},
				expand_lines = true,
				layouts = {
					{
						elements = {
							-- Elements can be strings or table with id and size keys
							{ id = "scopes", size = 0.25 },
							"breakpoints",
							"stacks",
							"watches",
						},
						size = 40, -- 40 columns
						position = "left",
					},
					{
						elements = {
							"repl",
							"console",
						},
						size = 0.25, -- 25% of total lines
						position = "bottom",
					},
				},
				controls = {
					enabled = true,
					element = "repl",
					icons = {
						pause = "",
						play = "",
						step_into = "",
						step_over = "",
						step_out = "",
						step_back = "",
						run_last = "↻",
						terminate = "□",
					},
				},
				floating = {
					max_height = nil,
					max_width = nil,
					border = "single",
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				windows = { indent = 1 },
				render = {
					max_type_length = nil,
					max_value_lines = 100,
				},
			})

			-- Auto-open/close DAP UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- DAP UI keymaps
			vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
			vim.keymap.set("n", "<leader>de", dapui.eval, { desc = "Evaluate expression" })
			vim.keymap.set("v", "<leader>de", dapui.eval, { desc = "Evaluate selection" })
			vim.keymap.set("n", "<leader>df", function()
				dapui.float_element("scopes")
			end, { desc = "Float scopes" })
			vim.keymap.set("n", "<leader>dr", function()
				dapui.float_element("repl")
			end, { desc = "Float REPL" })
		end,
	},

	-- Virtual text for debugging (shows variable values inline)
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("nvim-dap-virtual-text").setup({
				enabled = true,
				enabled_commands = true,
				highlight_changed_variables = true,
				highlight_new_as_changed = false,
				show_stop_reason = true,
				commented = false,
				only_first_definition = true,
				all_references = false,
				clear_on_continue = false,
				display_callback = function(variable, buf, stackframe, node, options)
					if options.virt_text_pos == "inline" then
						return " = " .. variable.value
					else
						return variable.name .. " = " .. variable.value
					end
				end,
				virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",
				all_frames = false,
				virt_lines = false,
				virt_text_win_col = nil,
			})

			-- Toggle virtual text
			vim.keymap.set("n", "<leader>dv", function()
				require("nvim-dap-virtual-text").toggle()
			end, { desc = "Toggle DAP virtual text" })
		end,
	},

	-- Go-specific DAP extensions
	{
		"leoluz/nvim-dap-go",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("dap-go").setup({
				-- Additional dap configurations can be added
				dap_configurations = {
					{
						type = "go",
						name = "Attach remote",
						mode = "remote",
						request = "attach",
					},
				},
				-- Delve configurations
				delve = {
					path = "dlv",
					initialize_timeout_sec = 20,
					port = "${port}",
					args = {},
					build_flags = "",
				},
			})

			-- Go-specific debugging keymaps
			vim.keymap.set("n", "<leader>dgt", function()
				require("dap-go").debug_test()
			end, { desc = "Debug Go test" })
			vim.keymap.set("n", "<leader>dgL", function()
				require("dap-go").debug_last_test()
			end, { desc = "Debug last Go test" })
		end,
		ft = "go",
	},

	-- Telescope DAP integration for better debugging workflow
	{
		"nvim-telescope/telescope-dap.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("telescope").load_extension("dap")

			-- Telescope DAP keymaps
			vim.keymap.set("n", "<leader>dcc", function()
				require("telescope").extensions.dap.commands()
			end, { desc = "DAP commands" })
			vim.keymap.set("n", "<leader>dco", function()
				require("telescope").extensions.dap.configurations()
			end, { desc = "DAP configurations" })
			vim.keymap.set("n", "<leader>dlb", function()
				require("telescope").extensions.dap.list_breakpoints()
			end, { desc = "List breakpoints" })
			vim.keymap.set("n", "<leader>dv", function()
				require("telescope").extensions.dap.variables()
			end, { desc = "DAP variables" })
			vim.keymap.set("n", "<leader>df", function()
				require("telescope").extensions.dap.frames()
			end, { desc = "DAP frames" })
		end,
	},
}
