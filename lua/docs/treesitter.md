# 🌲 Treesitter Guide

Complete guide to nvim-treesitter for superior syntax highlighting, code understanding, and text manipulation.

## 🚀 Overview

Treesitter provides:

- **Advanced syntax highlighting** - Context-aware, accurate colors
- **Code understanding** - AST-based parsing for better navigation
- **Text objects** - Smart selection and manipulation
- **Indentation** - Language-aware auto-indentation
- **Folding** - Intelligent code folding (when enabled)

## 📦 Installed Parsers

### Core Languages

- **lua** - Neovim configuration
- **vim** - Vim script support
- **vimdoc** - Vim help documentation
- **query** - Treesitter queries

### Web Development

- **html** - HTML markup
- **css** - Stylesheets
- **javascript** - JavaScript/ES6+
- **json** - JSON data files

### Systems Programming

- **c** - C programming language
- **python** - Python scripts
- **go** - Go programming
- **bash** - Shell scripts

### Documentation

- **markdown** - Markdown files
- **query** - Treesitter query language

## 🎨 Syntax Highlighting Features

### Advanced Highlighting

- **Context-aware colors** - Variables, functions, keywords get different colors based on context
- **Semantic tokens** - Understanding of scope and meaning
- **Consistent theming** - Works perfectly with Tokyo Night colorscheme
- **Real-time updates** - Highlighting updates as you type

### Highlighting Groups

Common highlight groups used:

- `@variable` - Variable names
- `@function` - Function names and calls
- `@keyword` - Language keywords
- `@string` - String literals
- `@comment` - Comments
- `@type` - Type annotations
- `@constant` - Constants and literals

## 🔧 Configuration Features

### Auto-Installation

- **Automatic parser installation** - Parsers install when opening new file types
- **Sync installation** - Can install parsers synchronously if needed
- **Update command** - `:TSUpdate` keeps parsers current

### Enabled Features

#### Highlighting

```lua
highlight = {
  enable = true,
  additional_vim_regex_highlighting = false,  -- Disable for better performance
}
```

#### Indentation

```lua
indent = {
  enable = true  -- Language-aware indentation
}
```

## 🛠️ Management Commands

### Installation Commands

```vim
:TSInstall <language>        # Install specific parser
:TSInstall all              # Install all maintained parsers
:TSUpdate                   # Update all installed parsers
:TSUpdate <language>        # Update specific parser
```

### Information Commands

```vim
:TSInstallInfo              # Show installation status
:TSModuleInfo               # Show available modules
:checkhealth nvim-treesitter # Health check
```

### Parser Management

```vim
:TSUninstall <language>     # Remove parser
:TSEnable highlight         # Enable highlighting
:TSDisable highlight        # Disable highlighting
:TSToggle highlight         # Toggle highlighting
```

## 🎯 Usage Examples

### Language-Specific Features

#### Lua

- **Neovim API highlighting** - `vim` global and functions highlighted specially
- **String interpolation** - Template strings and escapes
- **Table syntax** - Proper highlighting of Lua tables

#### Go

- **Struct highlighting** - Fields and methods clearly distinguished
- **Interface definitions** - Clear visual separation
- **Error handling** - `if err != nil` patterns highlighted

#### Python

- **Decorator highlighting** - `@decorator` syntax
- **F-string support** - Template literal highlighting
- **Type hints** - Proper annotation highlighting

#### JavaScript

- **JSX support** - React component highlighting
- **Template literals** - Backtick string interpolation
- **Arrow functions** - Modern JS syntax support

## 🔍 Debugging and Inspection

### Treesitter Playground (Optional)

If you want to inspect treesitter parsing:

```vim
# Install playground plugin first
:TSPlaygroundToggle         # Open syntax tree inspector
:TSHighlightCapturesUnderCursor  # Show highlight groups
```

### Query Information

```vim
:TSEditQuery highlights <lang>  # Edit highlight queries
:TSEditQuery indents <lang>     # Edit indentation queries
```

## 🎨 Theming Integration

### Tokyo Night Integration

- **Consistent colors** - All treesitter highlights use Tokyo Night palette
- **Semantic meaning** - Colors have consistent meaning across languages
- **Readability optimized** - Contrast and brightness tuned for long coding sessions

### Custom Highlight Groups

You can customize specific highlighting:

```lua
vim.api.nvim_set_hl(0, "@variable", { fg = "#7aa2f7" })
vim.api.nvim_set_hl(0, "@function", { fg = "#9ece6a" })
```

## 📈 Performance

### Optimization Features

- **Incremental parsing** - Only re-parses changed parts of the file
- **Lazy loading** - Parsers load only when needed
- **Efficient highlighting** - Better performance than regex-based highlighting
- **Memory efficient** - Shared parser instances across buffers

### Performance Tips

1. **Disable vim regex highlighting** - `additional_vim_regex_highlighting = false`
2. **Use latest parsers** - Regular `:TSUpdate` for bug fixes
3. **Monitor large files** - Treesitter may slow down on very large files

## 🔧 Adding New Languages

### Automatic Installation

Most parsers install automatically when opening supported files.

### Manual Installation

```vim
:TSInstall <language>       # Install specific parser
```

### Configuration

Add to `ensure_installed` in `treesitter.lua`:

```lua
ensure_installed = {
  "lua", "vim", "python", "go",
  "your_new_language"  -- Add here
}
```

## 🐛 Troubleshooting

### Common Issues

#### Parser Not Working

```vim
:TSInstallInfo              # Check if parser is installed
:TSInstall <language>       # Reinstall parser
:checkhealth nvim-treesitter # Health check
```

#### Highlighting Incorrect

```vim
:TSDisable highlight        # Disable temporarily
:TSEnable highlight         # Re-enable
:TSUpdate                   # Update parsers
```

#### Performance Issues

```vim
# For large files, you can disable temporarily
:TSDisable highlight <buffer>
```

#### Installation Failures

```vim
:checkhealth nvim-treesitter # Check system requirements
# Ensure you have gcc/clang installed
# On macOS: xcode-select --install
# On Ubuntu: sudo apt install build-essential
```

## 🔄 Integration with Other Plugins

### LSP Integration

- **Enhanced completions** - Treesitter provides better context for LSP
- **Symbol highlighting** - Works together for semantic highlighting
- **Code navigation** - Better understanding of code structure

### Telescope Integration

- **Better search** - Understanding of code structure for more accurate searches
- **Symbol picking** - Enhanced symbol recognition

### Neo-tree Integration

- **File type icons** - Accurate file type detection
- **Syntax-aware features** - Better file understanding

## 💡 Advanced Features

### Incremental Selection (Optional)

Can be enabled for smart text selection:

```lua
incremental_selection = {
  enable = true,
  keymaps = {
    init_selection = "gnn",
    node_incremental = "grn",
    scope_incremental = "grc",
    node_decremental = "grm",
  },
}
```

### Text Objects (Optional)

Smart text objects for selection:

```lua
textobjects = {
  select = {
    enable = true,
    keymaps = {
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["ac"] = "@class.outer",
      ["ic"] = "@class.inner",
    },
  },
}
```

## 🎯 Best Practices

1. **Keep parsers updated** - Run `:TSUpdate` regularly
2. **Use health checks** - `:checkhealth nvim-treesitter` for issues
3. **Disable for large files** - If performance becomes an issue
4. **Learn highlight groups** - Understand what different colors mean
5. **Monitor new languages** - Auto-install makes adding support easy

---

**💡 Pro Tip**: Treesitter highlighting is much more accurate than regex-based highlighting. The colors you see actually represent the meaning of your code!

_Superior syntax highlighting - Understanding your code better_ ⚡
