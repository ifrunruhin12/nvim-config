-- Telescope fuzzy finder configuration

return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        
        telescope.setup({
            defaults = {
                prompt_prefix = "🔍 ",
                selection_caret = " ",
                path_display = { "smart" },
                file_ignore_patterns = { 
                    "node_modules", 
                    ".git/", 
                    "%.lock",
                    "lazy-lock.json"
                },
                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                        ["<esc>"] = actions.close,
                    },
                },
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--hidden",
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                    find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
                },
                live_grep = {
                    additional_args = function()
                        return { "--hidden" }
                    end,
                },
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({})
                },
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                }
            }
        })

        -- Load telescope extensions
        pcall(telescope.load_extension, "fzf")
        telescope.load_extension("ui-select")

        -- Keymaps for Telescope
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep (Search in Files)" })
        vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find Word under Cursor" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
        vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent Files" })
        vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Find Commands" })
    end
}
