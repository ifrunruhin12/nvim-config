# 🎯 Formatting Guide

Complete guide to automatic code formatting using none-ls (formerly null-ls) for consistent, beautiful code.

## 🚀 Overview

The formatting system provides:
- **Automatic formatting** - Code formats on save
- **Multiple formatters** - Support for many languages
- **Manual formatting** - Format on demand with `<Space>f`
- **No conflicts** - LSP servers handle completion, none-ls handles formatting
- **Extensible** - Easy to add new formatters and linters

## 🎮 Key Bindings

| Key | Action | Description |
|-----|--------|-------------|
| `<Space>f` | Format file | Manual formatting of current file |
| `<Space>ca` | Code actions | Show available code actions |

**Note**: Formatting also happens automatically when saving files (`<Space>w` or `:w`).

## 📦 Supported Languages & Formatters

### Lua
- **stylua** - Opinionated Lua formatter
- **Features**: Consistent indentation, spacing, and style
- **Config**: Follows standard Lua conventions

### Go
- **goimports** - Formats code and manages imports
- **gofmt** - Standard Go formatter
- **Features**: Auto-import management, standard Go style
- **Order**: goimports runs first, then gofmt

### Python
- **black** - The uncompromising Python code formatter
- **isort** - Import sorting and organization
- **Features**: Consistent line length, import organization
- **Standards**: PEP 8 compliance

### JavaScript/TypeScript
- **prettier** - Opinionated code formatter
- **Supported files**: 
  - JavaScript (.js, .jsx)
  - TypeScript (.ts, .tsx)
  - Vue (.vue)
  - CSS/SCSS (.css, .scss, .less)
  - HTML (.html)
  - JSON (.json, .jsonc)
  - YAML (.yaml, .yml)
  - Markdown (.md)
  - GraphQL (.graphql)
  - Handlebars (.hbs)

### Ruby
- **rubocop** - Ruby static code analyzer and formatter
- **Features**: Style enforcement, auto-correction
- **Standards**: Ruby community style guide

### Shell Scripts
- **shfmt** - Shell script formatter
- **Features**: Consistent shell script styling
- **Supported**: Bash, sh, and other shell scripts

### General
- **codespell** - Spell checker for code comments and strings
- **Features**: Catches common typos in code

## ⚙️ How It Works

### Format on Save
1. **File save triggered** (`<Space>w` or `:w`)
2. **none-ls checks** if formatting is available for file type
3. **Formatter runs** automatically before save completes
4. **File saved** with formatted content

### Manual Formatting
1. **Press `<Space>f`** in normal mode
2. **none-ls formats** current buffer
3. **Changes applied** immediately
4. **File remains unsaved** until you save manually

### Conflict Prevention
- **LSP servers**: Handle completions, diagnostics, go-to-definition
- **none-ls only**: Handles formatting and some linting
- **Clean separation**: No duplicate formatting attempts

## 🔧 Installation Requirements

Most formatters are installed automatically, but some may need manual installation:

### System Dependencies
```bash
# Lua formatter
cargo install stylua

# Go formatters (usually installed with Go)
go install golang.org/x/tools/cmd/goimports@latest

# Python formatters
pip install black isort

# JavaScript/TypeScript formatter
npm install -g prettier

# Ruby formatter
gem install rubocop

# Shell formatter
brew install shfmt  # macOS
sudo apt install shfmt  # Ubuntu

# Spell checker
pip install codespell
```

### Mason Integration
Some formatters can be installed through Mason:
```vim
:Mason
# Search and install: stylua, prettier, black, isort, etc.
```

## 🛠️ Customization

### Adding New Formatters

1. **Add to sources** in `none-ls.lua`:
```lua
sources = {
  -- Existing formatters...
  null_ls.builtins.formatting.your_formatter,
}
```

2. **Install formatter** on your system
3. **Restart Neovim** to apply changes

### Language-Specific Configuration

#### Prettier Configuration
Create `.prettierrc` in project root:
```json
{
  "semi": false,
  "singleQuote": true,
  "tabWidth": 2,
  "trailingComma": "es5"
}
```

#### Black Configuration
Create `pyproject.toml`:
```toml
[tool.black]
line-length = 88
target-version = ['py38']
```

#### Stylua Configuration
Create `stylua.toml`:
```toml
line_endings = "Unix"
indent_type = "Spaces"
indent_width = 2
```

### Disabling Formatters

#### Temporarily Disable
```lua
-- In none-ls.lua, comment out formatter:
-- null_ls.builtins.formatting.black,
```

#### File-Type Specific Disable
```lua
null_ls.builtins.formatting.prettier.with({
  disabled_filetypes = { "markdown" }
})
```

#### Project-Specific Disable
Create `.null-ls-disable` file in project root.

## 🔍 Diagnostics & Linting

### Available Linters
- **codespell** - Spell checking in code
- **rubocop** - Ruby style and error detection
- **gitsigns** - Git change indicators (code actions)

### Diagnostic Display
- **Inline indicators**: Errors and warnings show in code
- **Status line**: Diagnostic counts in lualine
- **Floating windows**: Detailed diagnostic information

## 🐛 Troubleshooting

### Formatting Not Working

#### Check none-ls Status
```vim
:NullLsInfo                 # Show attached none-ls sources
:checkhealth null-ls        # Health check
```

#### Check Formatter Installation
```vim
# Test formatter manually
:!stylua --version          # For Lua
:!black --version           # For Python
:!prettier --version        # For JavaScript
```

#### Debug Formatting
```vim
:NullLsLog                  # View none-ls logs
```

### Format on Save Not Triggering

#### Check Autocmd
```vim
:autocmd BufWritePre        # Should show LspFormatting group
```

#### Manual Restart
```vim
:FixLSP                     # Restart all LSP clients
```

### Formatter Conflicts

#### Multiple Formatters
If you have multiple formatters for the same language:
```lua
-- Disable LSP formatting to avoid conflicts
client.server_capabilities.documentFormattingProvider = false
```

#### Wrong Formatter Used
Check source priority and disable unwanted ones in configuration.

### Performance Issues

#### Slow Formatting
- **Large files**: Consider disabling for very large files
- **Network formatters**: Some formatters may be slow
- **Background formatting**: Use manual formatting for large files

```vim
# Disable for current buffer
:NullLsDisable formatting
```

## 💡 Best Practices

### Development Workflow
1. **Set up project configs** - Use `.prettierrc`, `stylua.toml`, etc.
2. **Team consistency** - Share formatter configs in version control
3. **Pre-commit hooks** - Consider git hooks for additional safety
4. **Editor integration** - Format-on-save keeps code clean

### Performance Tips
1. **Project-specific configs** - Faster than global configs
2. **Selective formatting** - Disable for files that don't need it
3. **Manual formatting** - For large files or when debugging
4. **Regular updates** - Keep formatters updated for best performance

### Code Quality
1. **Consistent style** - Let formatters handle style decisions
2. **Focus on logic** - Don't worry about formatting while coding
3. **Team standards** - Use shared configurations
4. **Incremental adoption** - Add formatters gradually to existing projects

## 🔗 Integration

### LSP Integration
- **Clean separation** - LSP handles semantics, none-ls handles style
- **No conflicts** - Formatters disabled on LSP servers
- **Unified experience** - Both work together seamlessly

### Git Integration
- **Pre-commit formatting** - Files formatted before commits
- **Diff cleanliness** - Consistent formatting reduces noise
- **Code review** - Focus on logic, not style

### Editor Integration
- **Status indicators** - Lualine shows formatting status
- **Error display** - Diagnostics integrate with LSP display
- **Quick access** - Single keymap for manual formatting

## 📈 Advanced Usage

### Custom Formatters
Create custom formatting commands:
```lua
null_ls.register({
  null_ls.builtins.formatting.stylua.with({
    args = { "--indent-type", "Spaces", "--stdin-filepath", "$FILENAME", "-" }
  })
})
```

### Conditional Formatting
Format only specific files:
```lua
null_ls.builtins.formatting.prettier.with({
  condition = function(utils)
    return utils.root_has_file({ "package.json", ".prettierrc" })
  end
})
```

### Multi-Language Projects
Different formatters for different parts of monorepo:
```lua
-- Configure based on file path or project structure
```

---

**💡 Pro Tip**: Set up project-specific formatter configurations (like `.prettierrc`) to ensure team consistency and faster formatting!

*Automatic code formatting - Beautiful code without the effort* ⚡
