-- This files serves as the entry point for all plugin configurations
-- Each plugin's configuration is loaded from it's own file in this folder

return {
    require('plugins.colorscheme'),
    require('plugins.devicons'),
    require('plugins.neo-tree'),
    require('plugins.nui'),
    require('plugins.plenary'),
    require('plugins.telescope'),
    require('plugins.treesitter'),
    require('plugins.lualine'),
    require('plugins.lsp-config'),
    -- Will add more plugins require here if necesary
}
