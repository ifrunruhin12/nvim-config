-- Treesitter configuration for better syntax highlighting
-- Uses nvim-treesitter v2 API (requires Neovim 0.12+)

return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,  -- v2 does not support lazy-loading
    build = ":TSUpdate",
    config = function()
        -- v2 setup: only install_dir is configurable here
        -- highlight and indent are handled by Neovim's built-in treesitter support
        require("nvim-treesitter").setup({})

        -- Install parsers (no-op if already installed)
        require("nvim-treesitter").install({
            "lua", "vim", "vimdoc", "markdown", "query",
            "c", "python", "go", "bash", "html", "css",
            "javascript", "json",
        })

        -- Enable treesitter-based highlighting (built into Neovim)
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                local ok = pcall(vim.treesitter.start)
                if not ok then
                    -- parser not available for this filetype, silently skip
                end
            end,
        })
    end,
}
