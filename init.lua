-- ===========================
-- |  Basic lua config       |
-- ===========================


-- ===========================
-- Set leader key (for later)
-- ===========================
vim.g.mapleader = ' '

-- ===========================
-- Basic options
-- ===========================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.cursorline = true

-- ===========================
-- Bootstrap lazy.nvim
-- ===========================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- ==========================
-- Key mappings
-- ==========================
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")

-- ==========================
-- Plugins list
-- ==========================
require("lazy").setup({
    -- Tokyonight colorscheme
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme tokyonight-night]])
        end
    },

    -- Plenary (needed for Telescope and many plugins)
    {
        "nvim-lua/plenary.nvim"
    },

    -- Telescope fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                defaults = {
                    prompt_prefix = "🔍 ",
                    selection_caret = " ",
                    path_display = { "smart" },
                }
            })
            -- Keymaps for Telescope
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
        end
    },

    -- Treesitter for better syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        -- build = ":TSUpdate", -- Automatically updates parsers
        config = function()
            require("nvim-treesitter.configs").setup({

                -- parser_install_dir = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/parser",
                -- Languages you want to install
                ensure_installed = { "lua", "vim", "vimdoc", "markdown", "query", "c", "python", "go", "bash", "html", "css", "javascript", "json" },
                
                -- Install languages synchronously (only if you prefer)
                sync_install = false,
                auto_install = false,

                -- Enable highlighting
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },

                -- Enable indentation
                indent = { enable = true },
            })
        end
    }
})


-- ==========================
-- Auto commands
-- =========================
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        vim.cmd("echo 'File Saved'")
    end
})

