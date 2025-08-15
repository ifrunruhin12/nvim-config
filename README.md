# 🚀 My Sexy Neovim Setup

> **Status:** 🚧 Work in Progress - Now with better organization!

A minimal, modern Neovim configuration built for speed and efficiency. This is the beginning of something beautiful.

## ✨ Current Features

- **🌙 Tokyo Night** - Beautiful dark theme that's easy on the eyes
- **🌳 Neo-tree** - Powerful file explorer with Git integration (see `lua/neotree.md` for full documentation)
- **🔍 Telescope** - Lightning-fast fuzzy finder for files and content
- **🌲 Treesitter** - Superior syntax highlighting and code understanding
- **⚡ Lazy.nvim** - Modern plugin manager for blazing fast startup

## 🎯 What's Included

```lua
-- Essential plugins currently configured:
🎨 folke/tokyonight.nvim       -- Colorscheme
🌳 nvim-neo-tree/neo-tree.nvim -- File explorer with Git integration
🔭 nvim-telescope/telescope.nvim -- Fuzzy finder
🌲 nvim-treesitter/nvim-treesitter -- Syntax highlighting
📦 folke/lazy.nvim             -- Plugin manager
```

## 🚀 Quick Start

1. Backup your existing Neovim config (if any)
2. Clone this repo to your Neovim config directory
3. Launch Neovim and let the magic happen!

## 🏗️ Project Structure

```
~/.config/nvim/
├── init.lua           # Main configuration file
├── lua/
│   ├── plugins.lua    # All plugin configurations
│   └── neotree.md     # Neo-tree documentation
└── README.md          # This file
```

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
| `<Space>fg` | Live grep |
| `<Space>fb` | Find buffers |
| `<Space>fh` | Help tags |

### 🌳 Neo-tree
| Key | Action |
|-----|--------|
| `<Space>e` | Toggle file explorer |
| `<Space>o` | Focus file explorer |
| `?` | Show all key mappings |

*For full Neo-tree documentation, see [lua/neotree.md](lua/neotree.md)*

## 🔧 Configuration

- **Plugin Configs**: All plugin configurations are in `lua/plugins.lua`
- **Custom Settings**: Core settings are in `init.lua`
- **Documentation**: Plugin-specific docs are in the `lua/` directory

## 🔮 Coming Soon

- LSP configuration for intelligent code completion
- Status line customization
- More language support
- Custom snippets
- And much more...

## 📸 Screenshots

*Coming soon once the config is complete!*

---

**Note:** This is a living configuration that's constantly evolving. Stay tuned for updates! ⚡
