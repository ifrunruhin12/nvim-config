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
require("vim-options")


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
-- Basic keymaps
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")

-- ==========================
-- Load plugin configurations
-- ==========================
require("lazy").setup("plugins")

-- ==========================
-- Auto commands
-- ==========================
-- Add any global autocommands here

-- ==========================
-- Custom functions
-- ==========================
-- Add any custom utility functions here
