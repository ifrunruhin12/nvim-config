-- Treesitter configuration for better syntax highlighting

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "lua", "vim", "vimdoc", "markdown", "query",
                "c", "python", "go", "bash", "html", "css",
                "javascript", "json"
            },

            sync_install = false,
            auto_install = true,

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },

            indent = { enable = true },
        })
    end
}
