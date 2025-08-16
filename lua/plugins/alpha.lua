-- Alpha.nvim dashboard configuration
-- Cool welcome screen for Neovim

return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Set custom header with epic ASCII art
		dashboard.section.header.val = {
			[[                                                      ]],
			[[ ███▄    █  ▓█████ ▒█████   ██▒   █▓  ██▓ ███▄ ▄███▓ ]],
			[[ ██ ▀█   █  ▓█   ▀▒██▒  ██▒▓██░   █▒▒▓██▒▓██▒▀█▀ ██▒ ]],
			[[▓██  ▀█ ██▒ ▒███  ▒██░  ██▒ ▓██  █▒░▒▒██▒▓██    ▓██░ ]],
			[[▓██▒  ▐▌██▒ ▒▓█  ▄▒██   ██░  ▒██ █░░░░██░▒██    ▒██  ]],
			[[▒██░   ▓██░▒░▒████░ ████▓▒░   ▒▀█░  ░░██░▒██▒   ░██▒ ]],
			[[░ ▒░   ▒ ▒ ░░░ ▒░ ░ ▒░▒░▒░    ░ ▐░   ░▓  ░ ▒░   ░  ░ ]],
			[[░ ░░   ░ ▒░░ ░ ░    ░ ▒ ▒░    ░ ░░  ░ ▒ ░░  ░      ░ ]],
			[[   ░   ░ ░     ░  ░ ░ ░ ▒        ░  ░ ▒ ░░      ░    ]],
			[[         ░ ░   ░      ░ ░        ░    ░         ░    ]],
			[[                                                      ]],
			[[           🚀 Welcome to your coding universe! 🌌     ]],
			[[                                                      ]],
		}

		-- Set custom menu with useful shortcuts
		dashboard.section.buttons.val = {
			dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f", "🔍  Find File", ":Telescope find_files<CR>"),
			dashboard.button("r", "📁  Recent Files", ":Telescope oldfiles<CR>"),
			dashboard.button("g", "🔎  Find Text", ":Telescope live_grep<CR>"),
			dashboard.button("c", "⚙️   Config", ":e $MYVIMRC<CR>"),
			dashboard.button("p", "📦  Plugins", ":Lazy<CR>"),
			dashboard.button("m", "🛠️   Mason", ":Mason<CR>"),
			dashboard.button("h", "💡  Help", ":help<CR>"),
			dashboard.button("q", "👋  Quit", ":qa<CR>"),
		}

		-- Custom footer with dynamic stats
		local function footer()
			local total_plugins = require("lazy").stats().count
			local datetime = os.date("📅 %Y-%m-%d   🕐 %H:%M:%S")
			local version = vim.version()
			local nvim_version = "v" .. version.major .. "." .. version.minor .. "." .. version.patch

			return {
				"",
				"🔥 " .. total_plugins .. " plugins loaded",
				"⚡ Neovim " .. nvim_version,
				datetime,
				"",
				"💻 Happy coding! Keep pushing boundaries! 🚀",
			}
		end

		dashboard.section.footer.val = footer()

		-- Layout configuration
		dashboard.config.layout = {
			{ type = "padding", val = 2 },
			dashboard.section.header,
			{ type = "padding", val = 2 },
			dashboard.section.buttons,
			{ type = "padding", val = 1 },
			dashboard.section.footer,
		}

		-- Styling
		dashboard.section.header.opts.hl = "AlphaHeader"
		dashboard.section.buttons.opts.hl = "AlphaButtons"
		dashboard.section.footer.opts.hl = "AlphaFooter"

		-- Custom highlight groups
		vim.cmd([[
      highlight AlphaHeader guifg=#7aa2f7
      highlight AlphaButtons guifg=#9ece6a
      highlight AlphaFooter guifg=#565f89
    ]])

		-- Disable folding on alpha buffer
		vim.cmd([[
      autocmd FileType alpha setlocal nofoldenable
    ]])

		-- Set up alpha
		alpha.setup(dashboard.config)

		-- Auto-open alpha when starting Neovim without arguments
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyVimStarted",
			callback = function()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				dashboard.section.footer.val = {
					"",
					"🔥 " .. stats.count .. " plugins loaded in " .. ms .. "ms",
					"⚡ Neovim " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch,
					os.date("📅 %Y-%m-%d   🕐 %H:%M:%S"),
					"",
					"💻 Happy coding! Keep pushing boundaries! 🚀",
				}
				pcall(vim.cmd.AlphaRedraw)
			end,
		})
	end,
}
