# 🔍 Telescope Guide

Complete guide to Telescope.nvim - the lightning-fast fuzzy finder for files, content, and everything in between.

## 🚀 Overview

Telescope provides:

- **File finding** - Lightning-fast file discovery
- **Live grep** - Real-time text search across files
- **Buffer management** - Quick switching between open files
- **LSP integration** - Symbol search and navigation
- **Extensible** - Plugin ecosystem for additional functionality

## 🎮 Key Bindings

### Core Pickers

| Key         | Command      | Description                           |
| ----------- | ------------ | ------------------------------------- |
| `<Space>ff` | `find_files` | Find files in current directory       |
| `<Space>fg` | `live_grep`  | Search for text across all files      |
| `<Space>fb` | `buffers`    | Find and switch to open buffers       |
| `<Space>fh` | `help_tags`  | Search through Vim help documentation |

### Navigation Within Telescope

| Key                | Action                      |
| ------------------ | --------------------------- |
| `<C-j>` / `<Down>` | Next item                   |
| `<C-k>` / `<Up>`   | Previous item               |
| `<C-n>`            | Next item (alternative)     |
| `<C-p>`            | Previous item (alternative) |
| `<CR>`             | Select item                 |
| `<C-x>`            | Open in horizontal split    |
| `<C-v>`            | Open in vertical split      |
| `<C-t>`            | Open in new tab             |
| `<C-u>`            | Clear prompt                |
| `<C-c>` / `<Esc>`  | Close Telescope             |

### Preview Window

| Key     | Action              |
| ------- | ------------------- |
| `<C-f>` | Scroll preview down |
| `<C-b>` | Scroll preview up   |
| `<Tab>` | Toggle preview      |

## 🔍 Available Pickers

### File Pickers

#### `find_files` (`<Space>ff`)

- **Purpose**: Find files in current working directory
- **Features**: Respects `.gitignore`, hidden file support
- **Usage**: Type filename or partial path

#### `buffers` (`<Space>fb`)

- **Purpose**: List and switch between open buffers
- **Features**: Shows buffer status, quick switching
- **Usage**: Type buffer name or file path

### Text Pickers

#### `live_grep` (`<Space>fg`)

- **Purpose**: Search for text across all files
- **Features**: Real-time search, regex support
- **Usage**: Type search term, see results update live

#### `help_tags` (`<Space>fh`)

- **Purpose**: Search Vim/Neovim help documentation
- **Features**: Instant help access, fuzzy matching
- **Usage**: Type help topic or command

### LSP Pickers (when LSP is active)

#### `lsp_document_symbols`

```vim
:Telescope lsp_document_symbols
```

- **Purpose**: Browse symbols in current file
- **Features**: Functions, variables, classes

#### `lsp_workspace_symbols`

```vim
:Telescope lsp_workspace_symbols
```

- **Purpose**: Search symbols across entire project
- **Features**: Project-wide navigation

#### `lsp_references`

```vim
:Telescope lsp_references
```

- **Purpose**: Find all references to symbol under cursor
- **Features**: Quick navigation to usages

## ⚙️ Configuration Features

### UI Customization

- **Prompt prefix**: 🔍 for visual appeal
- **Selection caret**: Visual indicator for current selection
- **Smart path display**: Truncates long paths intelligently
- **Dropdown theme**: For ui-select integration

### Extensions

#### UI Select Extension

- **Purpose**: Replace Vim's default selection UI
- **Usage**: Automatic for code actions, LSP selections
- **Theme**: Dropdown style for better UX

## 🎯 Advanced Usage

### Search Modifiers

#### File Finding

```vim
# Find files including hidden ones
:Telescope find_files hidden=true

# Find files in specific directory
:Telescope find_files cwd=~/projects

# Search only specific file types
:Telescope find_files file_ignore_patterns={"*.log"}
```

#### Live Grep Options

```vim
# Search in specific directory
:Telescope live_grep cwd=~/projects

# Search with specific file types
:Telescope live_grep type_filter=lua

# Case sensitive search
:Telescope live_grep case_mode=true
```

### Custom Commands

You can create custom telescope commands:

```lua
vim.keymap.set("n", "<leader>fc", function()
  require("telescope.builtin").find_files({
    cwd = "~/.config/nvim"
  })
end, { desc = "Find config files" })
```

## 🔧 Performance Features

### Optimizations

- **Smart caching** - Recently accessed files load faster
- **Incremental loading** - Results appear as they're found
- **Efficient filtering** - Fast fuzzy matching algorithm
- **Preview caching** - File previews cached for speed

### Large Project Handling

- **Respects .gitignore** - Excludes unnecessary files
- **File limit handling** - Graceful handling of large directories
- **Smart sorting** - Most relevant results first

## 🎨 Visual Features

### Theming

- **Tokyo Night integration** - Matches your colorscheme
- **Bordered windows** - Clean, modern appearance
- **Syntax highlighting** - Previews show proper colors
- **Icons** - File type icons in results

### Layout Options

- **Horizontal layout** - Default configuration
- **Vertical layout** - For different screen sizes
- **Dropdown** - Compact selection interface
- **Cursor** - Appears at cursor position

## 🛠️ Customization

### Adding Custom Pickers

Add new keybindings for built-in pickers:

```lua
vim.keymap.set("n", "<leader>fo",
  require("telescope.builtin").oldfiles,
  { desc = "Recent files" })

vim.keymap.set("n", "<leader>fc",
  require("telescope.builtin").commands,
  { desc = "Commands" })
```

### Configuration Options

Modify `telescope.lua` for custom behavior:

```lua
defaults = {
  file_ignore_patterns = { "node_modules", ".git/" },
  layout_strategy = "horizontal",
  sorting_strategy = "ascending",
  layout_config = {
    horizontal = { preview_width = 0.6 }
  }
}
```

### Custom File Ignore Patterns

```lua
defaults = {
  file_ignore_patterns = {
    "%.git/",
    "node_modules/",
    "target/",
    "build/",
    "%.log"
  }
}
```

## 🔗 Integration

### LSP Integration

- **Automatic symbol pickers** - Available when LSP is active
- **Go to definition** - Enhanced with Telescope UI
- **Reference finding** - Better than built-in quickfix
- **Workspace symbols** - Project-wide symbol search

### Git Integration (Future Enhancement)

Popular extensions you can add:

- **Git files** - `git_files` picker
- **Git commits** - Browse commit history
- **Git branches** - Switch branches with preview

### Plugin Ecosystem

Popular Telescope extensions:

- `telescope-fzf-native.nvim` - Faster sorting
- `telescope-ui-select.nvim` - ✅ Already included
- `telescope-file-browser.nvim` - File browser
- `telescope-project.nvim` - Project management

## 🐛 Troubleshooting

### Common Issues

#### No Files Found

```vim
# Check current working directory
:pwd
# Change directory if needed
:cd /path/to/project
# Or use cwd option
:Telescope find_files cwd=/path/to/project
```

#### Live Grep Not Working

```vim
# Check if ripgrep is installed
:checkhealth telescope
# Install ripgrep (faster) or use vimgrep
# macOS: brew install ripgrep
# Ubuntu: sudo apt install ripgrep
```

#### Performance Issues

- **Limit file patterns**: Add more ignore patterns
- **Use file_ignore_patterns**: Exclude large directories
- **Install fzf-native**: For faster sorting

#### Preview Not Showing

- **Check file size**: Very large files may not preview
- **Toggle preview**: Use `<Tab>` to toggle
- **Check filetype**: Some files may not have preview support

## 💡 Usage Tips

### Efficient Searching

1. **Use partial matches** - Type key parts of filename
2. **Start with live_grep** - When you know what text to find
3. **Use help_tags** - Great for learning Vim features
4. **Buffer switching** - Faster than `:b` command

### Keyboard Workflow

1. **Muscle memory** - Learn the core 4 keybindings
2. **Use Ctrl keys** - For navigation within picker
3. **Split shortcuts** - `<C-x>` and `<C-v>` for splits
4. **Tab for preview** - Toggle when needed

### Search Strategies

- **File finding**: Start with most unique part of filename
- **Live grep**: Use specific terms, avoid common words
- **Symbol search**: Use when LSP is available
- **Help tags**: Great for discovering features

## 📈 Advanced Workflows

### Project Navigation

1. **Find files** (`<Space>ff`) - Navigate to specific files
2. **Live grep** (`<Space>fg`) - Find specific functionality
3. **LSP symbols** - Browse code structure
4. **Buffer management** (`<Space>fb`) - Switch contexts

### Code Exploration

1. **Symbol search** - Understand codebase structure
2. **Reference finding** - Track usage patterns
3. **Grep patterns** - Find similar code blocks
4. **Help integration** - Learn while coding

---

**💡 Pro Tip**: Telescope's fuzzy finding is very smart - you don't need to type exact matches. For "config/plugins/telescope.lua", typing "conf tel lua" will find it!

_Lightning-fast fuzzy finding - Navigate at the speed of thought_ ⚡
