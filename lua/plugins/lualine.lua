-- Updated lualine.nvim configuration with AI status indicator
-- Replace your existing lua/plugins/lualine.lua with this content

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "tokyonight", -- Match the Tokyo Night theme
				component_separators = { left = "│", right = "│" },
				section_separators = { left = "", right = "" },
				globalstatus = true, -- Use a single statusline at the bottom
				disabled_filetypes = { -- Disable lualine for certain filetypes
					statusline = { "NvimTree", "alpha" },
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = {
					-- AI Status indicator
					{
						function()
							if _G.codeium_status then
								return _G.codeium_status()
							else
								return ""
							end
						end,
						color = function()
							if vim.g.codeium_enabled then
								return { fg = "#9ece6a" } -- Green when enabled
							else
								return { fg = "#f7768e" } -- Red when disabled
							end
						end,
					},
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			extensions = { "fugitive", "nvim-tree" },
		})
	end,
}
