# 🚀 My Sexy Neovim Setup

> **Status:** 🚧 Work in Progress - Clean, modular, and fast!

A minimal, modern Neovim configuration built for speed and efficiency with a modular plugin architecture.

## ✨ Current Features

- **🌙 Tokyo Night** - Beautiful dark theme that's easy on the eyes
- **🌳 Neo-tree** - Powerful file explorer with Git integration
- **🔍 Telescope** - Lightning-fast fuzzy finder for files and content
- **🌲 Treesitter** - Superior syntax highlighting and code understanding
- **📊 Lualine** - Beautiful and informative status line
- **⚡ Lazy.nvim** - Modern plugin manager for blazing fast startup
- **📁 Modular Structure** - Each plugin in its own configuration file

## 🎯 What's Included

```lua
-- Essential plugins currently configured:
🎨 folke/tokyonight.nvim       -- Tokyo Night colorscheme
🌳 nvim-neo-tree/neo-tree.nvim -- File explorer with Git integration  
🔭 nvim-telescope/telescope.nvim -- Fuzzy finder
🌲 nvim-treesitter/nvim-treesitter -- Syntax highlighting
📊 nvim-lualine/lualine.nvim   -- Status line
🎭 nvim-tree/nvim-web-devicons -- File type icons
📦 folke/lazy.nvim             -- Plugin manager
🔧 MunifTanjim/nui.nvim        -- UI components
🛠️  nvim-lua/plenary.nvim      -- Utility functions
```

## 🚀 Quick Start

1. Backup your existing Neovim config (if any)
2. Clone this repo to your Neovim config directory:
   ```bash
   git clone <your-repo> ~/.config/nvim
   ```
3. Launch Neovim and let Lazy.nvim install all plugins automatically!
4. Restart Neovim to ensure everything loads properly

## 🏗️ Project Structure

```
~/.config/nvim/
├── init.lua                   # Main entry point
├── lazy-lock.json            # Plugin version lock file
├── lua/
│   ├── vim-options.lua       # Core Vim settings
│   ├── plugins.lua           # Plugin loader (redirects to plugins/init.lua)
│   ├── neotree.md           # Neo-tree documentation
│   └── plugins/             # Modular plugin configurations
│       ├── init.lua         # Plugin list and loader
│       ├── colorscheme.lua  # Tokyo Night theme
│       ├── devicons.lua     # File icons
│       ├── lualine.lua      # Status line
│       ├── neo-tree.lua     # File explorer
│       ├── nui.lua          # UI components
│       ├── plenary.lua      # Utility library
│       ├── telescope.lua    # Fuzzy finder
│       └── treesitter.lua   # Syntax highlighting
└── README.md                # This file
```

## ⚙️ Core Settings

Your Neovim is configured with these sensible defaults:
- **Line numbers**: Both absolute and relative
- **Indentation**: 4 spaces, no tabs
- **UI**: No line wrapping, cursor line highlighting
- **Leader key**: `<Space>`

## 🎮 Key Bindings

### 🖥️ General
| Key | Action |
|-----|--------|
| `<Space>w` | Save file |
| `<Space>q` | Quit |

### 🔍 Telescope
| Key | Action |
|-----|--------|
| `<Space>ff` | Find files |
| `<Space>fg` | Live grep (search in files) |
| `<Space>fb` | Find buffers |
| `<Space>fh` | Help tags |

### 🌳 Neo-tree
| Key | Action |
|-----|--------|
| `<Space>e` | Toggle file explorer |
| `<Space>o` | Focus file explorer |
| `<Space>gs` | Git status (floating window) |
| `?` | Show all key mappings (when in Neo-tree) |

*For complete Neo-tree documentation, see [lua/neotree.md](lua/neotree.md)*

## 🎨 Theme & UI

- **Colorscheme**: Tokyo Night (night variant)
- **Status line**: Lualine with Tokyo Night theme
- **Icons**: Web devicons for file types
- **File explorer**: Neo-tree with Git integration
- **Fuzzy finder**: Telescope with custom prompt

## 🔧 Plugin Management

This configuration uses **Lazy.nvim** for plugin management:
- Fast startup times with lazy loading
- Automatic plugin installation on first run
- Version locking with `lazy-lock.json`
- Modular configuration structure

Each plugin has its own configuration file in `lua/plugins/`, making it easy to:
- Add new plugins
- Modify existing configurations
- Remove plugins cleanly
- Understand what each plugin does

## 🌟 Language Support

Treesitter is configured with parsers for:
- **Lua** - For Neovim configuration
- **Vim** - Vim script support
- **Markdown** - Documentation
- **Web**: HTML, CSS, JavaScript, JSON
- **Systems**: C, Python, Go, Bash
- And more!

## 🔮 Coming Soon

- **LSP Configuration** - Intelligent code completion and diagnostics
- **Formatting & Linting** - Code quality tools
- **Git Integration** - Enhanced Git workflow
- **Custom Snippets** - Code templates
- **More Language Support** - Extended Treesitter parsers
- **Debugging Support** - DAP integration

## 📸 Screenshots

*Screenshots coming once the configuration reaches v1.0!*

## 🤝 Contributing

This is a personal configuration, but feel free to:
- Fork and adapt to your needs
- Suggest improvements
- Report issues
- Share your own modifications

## 📝 Notes

- Configuration is organized modularly for easy maintenance
- All plugins are locked to specific versions for stability
- Neo-tree replaces the default file explorer (netrw)
- Status line shows mode, git branch, file info, and more

---

**Note:** This configuration evolves constantly. Check the commit history to see what's new! ⚡

*Built with ❤️ for productive coding*
