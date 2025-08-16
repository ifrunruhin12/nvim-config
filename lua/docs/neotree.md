# 🌳 Neo-tree.nvim Documentation

A powerful file explorer plugin for Neovim with a modern UI and extensive features.

## 📋 Basic Navigation

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle Neo-tree |
| `<leader>o` | Focus Neo-tree |
| `q` | Close Neo-tree window |
| `?` | Show help for all available actions |

## 🗂️ File Operations

| Key | Action |
|-----|--------|
| `a` | Add a file (in current directory) |
| `A` | Add a directory |
| `d` | Delete file/directory |
| `r` | Rename file/directory |
| `y` | Copy to clipboard |
| `x` | Cut to clipboard |
| `p` | Paste from clipboard |
| `c` | Copy |
| `m` | Move |
| `R` | Refresh the tree |

## 🖥️ Window Management

| Key | Action |
|-----|--------|
| `s` | Open file in vertical split |
| `S` | Open file in horizontal split |
| `t` | Open file in new tab |
| `w` | Open with window picker |
| `P` | Toggle preview |
| `l` | Focus preview window |

## 🌲 Tree Navigation

| Key | Action |
|-----|--------|
| `<space>` | Toggle node (expand/collapse) |
| `<cr>` | Open file or toggle directory |
| `C` | Close current node |
| `z` | Close all nodes |
| `i` | Show file details |
| `<` | Switch to previous source |
| `>` | Switch to next source |

## 🔄 Git Integration

Neo-tree shows Git status indicators for files:

- `✚` - Added
- ` ` - Modified (empty space, but tracked by Git)
- `✖` - Deleted
- `󰁕` - Renamed
- ` ` - Untracked (empty space)
- `󰄱` - Unstaged changes

## ⚙️ Configuration Highlights

- **Position**: Left sidebar (40% width)
- **Features**: 
  - Git status indicators
  - File icons
  - File system operations
  - Preview support
  - Window picker

## 💡 Tips

- Press `?` in Neo-tree to see all available key mappings
- Use `R` to refresh if file changes aren't showing up
- The preview window can be toggled with `P`
- Use window picker (`w`) to quickly move files between splits

## 🚀 Getting Started

1. Open Neo-tree with `<leader>e`
2. Navigate with `j`/`k` or arrow keys
3. Press `?` to see all available commands

*Note: This file has been moved to `lua/neotree.md`*
