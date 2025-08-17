# ⚙️ Customization Guide

Complete guide to customizing your Neovim configuration - adding plugins, language servers, keymaps, and more.

## 🚀 Overview

Your Neovim configuration is designed to be easily customizable:

- **Modular structure** - Each plugin in its own file
- **Clean separation** - Settings, plugins, and docs organized
- **Version control** - All changes tracked and reversible
- **No conflicts** - Proper plugin isolation and management

## 📁 Configuration Structure

```
~/.config/nvim/
├── init.lua                    # Entry point - modify global settings here
├── lazy-lock.json             # Plugin versions (auto-managed)
├── .luarc.json               # Lua LSP config (don't modify)
├── lua/
│   ├── vim-options.lua       # Core Vim options - customize here
│   ├── plugins.lua           # Plugin loader (don't modify)
│   ├── docs/                 # Documentation (add guides here)
│   ├── snippets/            # Custom snippets - add languages here
│   └── plugins/             # Plugin configs - add/modify plugins here
│       ├── init.lua         # Plugin list - register new plugins
│       ├── lsp-config.lua   # LSP setup - add language servers
│       ├── telescope.lua    # Telescope config - add pickers
│       └── ...              # Individual plugin configurations
```

## 🔧 Adding New Plugins

### Step 1: Create Plugin Configuration

Create `lua/plugins/your-plugin.lua`:

```lua
-- Example: Adding a new plugin
return {
  "author/plugin-name",
  dependencies = {
    "required-dependency",  -- Optional
  },
  event = "VeryLazy",      -- When to load (optional)
  config = function()
    require("plugin-name").setup({
      -- Plugin configuration options
      option = "value",
    })

    -- Keymaps for this plugin
    vim.keymap.set("n", "<leader>x", ":PluginCommand<CR>",
      { desc = "Plugin action" })
  end,
}
```

### Step 2: Register in Plugin List

Add to `lua/plugins/init.lua`:

```lua
return {
  require("plugins.colorscheme"),
  require("plugins.telescope"),
  -- ... existing plugins
  require("plugins.your-plugin"),  -- Add your plugin here
}
```

### Step 3: Restart and Install

```vim
# Restart Neovim, then:
:Lazy sync              # Install new plugin
```

### Plugin Loading Strategies

#### Lazy Loading Options

```lua
return {
  "plugin/name",
  lazy = true,           # Don't load on startup
  event = "BufRead",     # Load on first file read
  cmd = "PluginCmd",     # Load when command is used
  keys = "<leader>x",    # Load when key is pressed
  ft = "lua",            # Load for specific filetype
}
```

## 🧠 Adding Language Servers

### Step 1: Install via Mason

```vim
:Mason                  # Open Mason UI
# Find your language server and install it
```

### Step 2: Add to LSP Config

Edit `lua/plugins/lsp-config.lua`:

```lua
-- Add to ensure_installed
ensure_installed = {
  "lua_ls", "gopls", "pyright",
  "your_language_server"        -- Add here
}

-- Add server setup
start_server("your_language_server", {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    -- Language server specific settings
    your_language = {
      option = "value",
    }
  }
})
```

### Step 3: Add Formatter (Optional)

Edit `lua/plugins/none-ls.lua`:

```lua
sources = {
  -- Existing formatters...
  null_ls.builtins.formatting.your_formatter,
  null_ls.builtins.diagnostics.your_linter,
}
```

### Language Server Examples

#### TypeScript/JavaScript

```lua
-- In lsp-config.lua
start_server("tsserver", {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
      }
    }
  }
})
```

#### Rust

```lua
-- In lsp-config.lua
start_server("rust_analyzer", {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy"
      }
    }
  }
})
```

## 🎮 Adding Custom Keymaps

### Global Keymaps

Add to `init.lua`:

```lua
-- Custom keymaps
vim.keymap.set("n", "<leader>x", ":command<CR>", { desc = "Description" })
vim.keymap.set("v", "<leader>y", ":visual_command<CR>", { desc = "Visual mode" })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save in insert mode" })
```

### Plugin-Specific Keymaps

Add to plugin configuration file:

```lua
-- In lua/plugins/your-plugin.lua
config = function()
  -- Plugin setup...

  -- Plugin keymaps
  vim.keymap.set("n", "<leader>pp", function()
    require("your-plugin").action()
  end, { desc = "Plugin action" })
end
```

### Keymap Best Practices

#### Use Descriptive Names

```lua
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
```

#### Group Related Keys

```lua
-- File operations
vim.keymap.set("n", "<leader>ff", find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", live_grep, { desc = "Find in files" })
vim.keymap.set("n", "<leader>fb", buffers, { desc = "Find buffers" })
```

#### Use Which-Key Integration (Optional)

```lua
-- Can be added later for keymap discovery
require("which-key").register({
  ["<leader>f"] = { name = "+file" },
  ["<leader>l"] = { name = "+lsp" },
})
```

## 🎨 Customizing Appearance

### Colorscheme Changes

Replace `lua/plugins/colorscheme.lua`:

```lua
return {
  "new-colorscheme/theme",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd([[colorscheme new-theme]])
  end
}
```

### Status Line Customization

Edit `lua/plugins/lualine.lua`:

```lua
require('lualine').setup {
  options = {
    theme = 'your-theme',
    -- Custom separators
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    -- Customize sections
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff' },
    lualine_c = { 'filename', 'your_custom_component' },
  }
}
```

### Custom Highlights

Add to any plugin config or `init.lua`:

```lua
-- Custom highlight groups
vim.api.nvim_set_hl(0, "MyHighlight", {
  fg = "#7aa2f7",
  bg = "#1a1b26",
  bold = true
})
```

## ⚙️ Vim Options Customization

Edit `lua/vim-options.lua`:

```lua
-- Core Vim settings
vim.opt.number = true
vim.opt.relativenumber = true

-- Add your custom options
vim.opt.conceallevel = 2      -- Hide markup in markdown
vim.opt.spell = true          -- Enable spell checking
vim.opt.spelllang = "en_us"   -- Spell check language
vim.opt.colorcolumn = "80"    -- Show column guide
vim.opt.scrolloff = 8         # Keep cursor away from edges
vim.opt.sidescrolloff = 8     # Horizontal scroll offset

-- Custom leader key (if you want to change from space)
-- vim.g.mapleader = ","
```

## 📝 Adding Custom Snippets

### Create Language Snippet File

Create `lua/snippets/your-language.lua`:

```lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("trigger", {
    t("Hello, "),
    i(1, "world"),
    t("!")
  }),

  s("func", {
    t("function "),
    i(1, "name"),
    t("("),
    i(2, "args"),
    t({") {", "  "}),
    i(3, "// body"),
    t({"", "}"})
  })
}
```

### Register Snippets

Add to `lua/snippets/init.lua`:

```lua
-- Load your custom snippets
ls.add_snippets("your_language", require("snippets.your-language"))
```

## 🔧 Advanced Customization

### Custom Commands

Add to `init.lua`:

```lua
-- Custom command example
vim.api.nvim_create_user_command("ReloadConfig", function()
  vim.cmd("source ~/.config/nvim/init.lua")
  vim.notify("Config reloaded!", vim.log.levels.INFO)
end, {})
```

### Autocommands

Add to `init.lua`:

```lua
-- Custom autocommands
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- Auto-save when leaving buffer
vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "*",
  callback = function()
    if vim.bo.modified then
      vim.cmd("silent! write")
    end
  end,
})
```

### Environment-Specific Config

Create `lua/local.lua` (gitignore this file):

```lua
-- Local overrides (not in version control)
return {
  -- Work-specific settings
  work_mode = true,
  custom_path = "/work/projects",
}
```

Load in `init.lua`:

```lua
-- Load local config if it exists
local ok, local_config = pcall(require, "local")
if ok then
  -- Apply local settings
  if local_config.work_mode then
    vim.opt.colorcolumn = "100"  -- Different line length for work
  end
end
```

## 🔄 Managing Updates

### Plugin Updates

```vim
:Lazy sync              # Update all plugins
:Lazy update            # Update with confirmation
:Lazy clean             # Remove unused plugins
```

### LSP Server Updates

```vim
:Mason                  # Open Mason UI
:MasonUpdate           # Update all servers
```

### Configuration Backup

```bash
# Create backup before major changes
cp -r ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d)

# Or use git
cd ~/.config/nvim
git add .
git commit -m "Backup before customization"
```

## 🐛 Troubleshooting Customizations

### Plugin Issues

```vim
:Lazy                   # Check plugin status
:Lazy log               # View installation logs
:checkhealth            # Overall health check
```

### LSP Issues

```vim
:LspInfo               # Check attached servers
:FixLSP                # Restart LSP (custom command)
:checkhealth lsp       # LSP health check
```

### Configuration Errors

```vim
:messages              # View error messages
:lua vim.print(vim.lsp.get_active_clients())  # Debug LSP
```

### Reverting Changes

#### Plugin Issues

Remove from `lua/plugins/init.lua` and restart.

#### LSP Issues

Comment out server setup in `lsp-config.lua`.

#### Keymap Issues

Remove from respective configuration files.

## 💡 Best Practices

### Organization

1. **One plugin per file** - Keep configurations separate
2. **Logical grouping** - Group related settings together
3. **Documentation** - Comment complex configurations
4. **Version control** - Track all changes with git

### Performance

1. **Lazy loading** - Use appropriate loading strategies
2. **Minimal dependencies** - Only add what you need
3. **Regular cleanup** - Remove unused plugins and configs
4. **Profile startup** - Monitor startup time with `:Lazy profile`

### Maintenance

1. **Regular updates** - Keep plugins and servers updated
2. **Health checks** - Run `:checkhealth` periodically
3. **Backup configs** - Before major changes
4. **Test changes** - In separate branch if using git

## 🎯 Common Customization Examples

### Adding Which-Key Plugin

```lua
-- lua/plugins/which-key.lua
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    require("which-key").setup()
  end
}
```

### Adding Git Signs

```lua
-- lua/plugins/gitsigns.lua
return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
  config = function()
    require("gitsigns").setup()
  end
}
```

### Adding Comment Plugin

```lua
-- lua/plugins/comment.lua
return {
  "numToStr/Comment.nvim",
  event = "BufReadPost",
  config = function()
    require("Comment").setup()
  end
}
```

---

**💡 Pro Tip**: Start with small customizations and test each change. The modular structure makes it easy to add features incrementally!

_Customization made easy - Your Neovim, your way_ ⚡
