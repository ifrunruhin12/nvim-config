# 🔧 LSP Configuration Documentation

A comprehensive Language Server Protocol setup for Neovim with support for Lua, Go, and Python development.

## 🚀 Overview

This LSP configuration provides intelligent code completion, diagnostics, and navigation features using:
- **Mason** - LSP server manager
- **Mason-LSPConfig** - Bridge between Mason and nvim-lspconfig
- **nvim-lspconfig** - LSP client configurations

## 📦 Supported Language Servers

| Language | Server | Features |
|----------|--------|----------|
| **Lua** | `lua_ls` | Neovim API support, diagnostics, completion |
| **Go** | `gopls` | Auto-imports, placeholders, formatting |
| **Python** | `pyright` | Type checking, auto-completion, imports |

## ⚡ Installation

The configuration automatically installs language servers on first run. You can also manage them manually:

```vim
:Mason                    " Open Mason UI
:MasonInstall lua_ls      " Install specific server
:MasonUninstall gopls     " Uninstall server
:MasonUpdate             " Update all servers
```

## 🎮 Key Bindings

### 📍 Navigation
| Key | Action | Description |
|-----|--------|-------------|
| `gd` | Go to definition | Jump to where symbol is defined |
| `gi` | Go to implementation | Jump to implementation |
| `gr` | Go to references | Show all references |
| `K` | Hover documentation | Show symbol information |

### 🔧 Code Actions
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>rn` | Rename symbol | Rename across project |
| `<leader>ca` | Code actions | Show available fixes/actions |
| `<leader>f` | Format code | Auto-format current file |

### 🩺 Diagnostics
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>dp` | Previous diagnostic | Go to previous error/warning |
| `<leader>dn` | Next diagnostic | Go to next error/warning |
| `<leader>dl` | Line diagnostics | Show diagnostics for current line |
| `<leader>dq` | Diagnostics list | Show all diagnostics in quickfix |

## 🔍 Diagnostic Symbols

Visual indicators for code issues:
- **Error** (E) - Red, code won't compile
- **Warning** (W) - Yellow, potential issues  
- **Information** (I) - Blue, suggestions
- **Hint** (H) - Gray, minor improvements

## ⚙️ Language-Specific Features

### 🌙 Lua (lua_ls)
- **Neovim API**: Full `vim` global support
- **Runtime**: Configured for LuaJIT
- **Workspace**: Recognizes Neovim runtime files
- **Completion**: Call snippet replacements
- **Diagnostics**: Disabled noisy warnings

```lua
-- Special globals recognized:
vim, use, describe, it, assert
```

### 🐹 Go (gopls)
- **Auto-imports**: Automatically manages imports
- **Placeholders**: Function parameter hints
- **Modules**: Full Go module support
- **Standards**: Follows Go conventions

```go
// Automatic import management
// Type-aware completions
// Built-in formatting
```

### 🐍 Python (pyright)
- **Type checking**: Static type analysis
- **Auto-completion**: Context-aware suggestions
- **Import resolution**: Smart import handling
- **Library support**: Recognizes installed packages

```python
# Type hints support
# Virtual environment detection
# Package auto-completion
```

## 🛠️ Configuration Files

### Primary Config Location
```
lua/plugins/lsp-config.lua
```

### Alternative Global Config
Create `.luarc.json` in project root for Lua-specific settings:
```json
{
  "Lua.diagnostics.globals": ["vim"],
  "Lua.workspace.checkThirdParty": false
}
```

## 🩹 Troubleshooting

### Common Issues

#### LSP Not Starting
```vim
:LspInfo                 " Check attached servers
:LspRestart             " Restart LSP clients  
:checkhealth lsp        " Health check
```

#### Missing Language Server
```vim
:Mason                  " Check installation status
:MasonLog              " View installation logs
```

#### Lua `vim` Global Warnings
- Ensure `lua_ls` is properly configured
- Check for `.luarc.json` in project root
- Verify LSP is attached with `:LspInfo`

#### Slow Performance
```vim
:LspStop               " Stop all LSP clients
:LspStart              " Restart LSP servers
```

### Debug Commands

```vim
:lua vim.print(vim.lsp.get_active_clients())  " Active clients
:lua vim.print(vim.diagnostic.get())          " Current diagnostics
:LspLog                                       " View LSP logs
```

## 🔧 Customization

### Adding New Language Servers

1. **Install via Mason**:
```vim
:MasonInstall <server-name>
```

2. **Add to configuration**:
```lua
-- In lsp-config.lua, add to ensure_installed:
ensure_installed = {
  "lua_ls", "gopls", "pyright",
  "your_new_server"  -- Add here
}

-- Add server setup:
lspconfig.your_new_server.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  -- server-specific settings
})
```

### Custom Key Mappings

Add to the `on_attach` function:
```lua
-- Custom mappings
vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
```

### Disable Specific Diagnostics

For Lua:
```lua
diagnostics = {
  disable = { "missing-fields", "incomplete-signature-doc" }
}
```

## 🎯 Performance Tips

1. **Lazy Loading**: LSP loads only when opening supported files
2. **Selective Installation**: Only install needed language servers
3. **Workspace Configuration**: Properly set workspace roots
4. **Diagnostic Throttling**: Configured to avoid excessive updates

## 🔮 Advanced Features

### Workspace Symbols
- `<leader>ws` - Search symbols across entire workspace
- Global symbol navigation and search

### Code Lens
- Inline actionable information
- Test running, reference counts

### Inlay Hints
- Type information displayed inline
- Parameter names in function calls

## 📈 Health Check

Regular maintenance commands:
```vim
:checkhealth mason     " Check Mason installation  
:checkhealth lsp       " Check LSP configuration
:Mason                 " Update language servers
:Lazy sync             " Update plugins
```

## 🤝 Integration

Works seamlessly with:
- **Telescope** - Symbol search and navigation
- **Treesitter** - Enhanced syntax highlighting  
- **Neo-tree** - File explorer with LSP diagnostics
- **Lualine** - Status line diagnostic indicators

---

**💡 Pro Tip**: Use `K` twice quickly to jump into hover documentation window for better readability!

*LSP Configuration - Making your code smarter, one symbol at a time* ⚡
