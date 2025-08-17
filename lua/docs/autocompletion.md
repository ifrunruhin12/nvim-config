# 💡 Autocompletion Guide

Complete guide to the nvim-cmp autocompletion system with snippets and intelligent code completion.

## 🚀 Overview

The autocompletion system provides intelligent code completion using:

- **nvim-cmp** - Main completion engine
- **LuaSnip** - Snippet engine
- **Multiple sources** - LSP, buffers, paths, and more
- **lspkind** - Beautiful completion menu icons

## 🎮 Key Bindings

### Basic Completion

| Key         | Action                                         |
| ----------- | ---------------------------------------------- |
| `<Tab>`     | Accept completion / Next item / Expand snippet |
| `<S-Tab>`   | Previous item / Jump backward in snippet       |
| `<CR>`      | Confirm selection                              |
| `<C-Space>` | Trigger completion menu                        |
| `<C-e>`     | Close completion menu                          |

### Navigation

| Key                | Action                    |
| ------------------ | ------------------------- |
| `<C-j>` / `<Down>` | Next completion item      |
| `<C-k>` / `<Up>`   | Previous completion item  |
| `<C-f>`            | Scroll documentation down |
| `<C-b>`            | Scroll documentation up   |

### Snippets

| Key     | Action                        |
| ------- | ----------------------------- |
| `<C-l>` | Expand snippet / Jump forward |
| `<C-h>` | Jump backward in snippet      |
| `<C-E>` | Cycle through snippet choices |

## 🔄 Completion Sources

Sources are prioritized in this order:

1. **LSP (1000)** - Intelligent code completions from language servers
2. **Snippets (900)** - Code templates and shortcuts
3. **Neovim Lua (800)** - Vim API completions (for Lua files)
4. **Buffer (700)** - Words from current and other open files
5. **Path (600)** - File system paths

### Source Indicators

- `[LSP]` - Language server completions
- `[Snip]` - Snippet completions
- `[Buf]` - Buffer word completions
- `[Path]` - File path completions
- `[Lua]` - Neovim Lua API completions

## 📝 Snippet System

### Available Snippet Collections

#### Go Snippets (`lua/snippets/go.lua`)

| Trigger  | Description                                   |
| -------- | --------------------------------------------- |
| `fastio` | Complete competitive programming I/O template |
| `main`   | Main function template                        |
| `for`    | For loop with customizable condition          |
| `func`   | Function declaration template                 |
| `if`     | If statement                                  |
| `struct` | Struct definition                             |
| `err`    | Error handling block                          |

#### Lua Snippets (`lua/snippets/lua.lua`)

| Trigger   | Description                   |
| --------- | ----------------------------- |
| `plugin`  | Plugin configuration template |
| `req`     | Require statement             |
| `func`    | Function definition           |
| `keymap`  | Vim keymap setup              |
| `autocmd` | Autocmd creation              |
| `opt`     | Vim option setting            |

### Creating Custom Snippets

1. **Create snippet file**: `lua/snippets/language.lua`
2. **Define snippets**:

```lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("trigger", {
    t("static text"),
    i(1, "placeholder"),
    t(" more text")
  })
}
```

3. **Load in init file**: Add to `lua/snippets/init.lua`

## 🎨 Menu Appearance

### Icons and Styling

- **Rounded borders** for completion and documentation windows
- **Icons** from lspkind for different completion types
- **Ghost text** preview of completions
- **Syntax highlighting** in documentation

### Completion Types

- 🔧 Function
- 📁 Variable
- 📄 Text
- 🏷️ Keyword
- 📦 Module
- 🎯 Snippet

## ⚙️ Advanced Configuration

### Completion Behavior

- **No auto-insert**: Must explicitly confirm completions
- **Menu always shown**: Even for single matches
- **Smart case**: Case-sensitive when using capitals
- **Minimum characters**: 3 for buffer completions

### Performance Features

- **Debounced updates**: Reduces CPU usage while typing
- **Lazy loading**: Sources load only when needed
- **Efficient filtering**: Fast completion matching

## 🛠️ Customization

### Adding New Sources

Add to nvim-cmp sources table:

```lua
sources = cmp.config.sources({
  { name = "nvim_lsp", priority = 1000 },
  { name = "your_source", priority = 500 }
})
```

### Custom Key Mappings

Modify mappings in the cmp.setup:

```lua
mapping = cmp.mapping.preset.insert({
  ["<Your-Key>"] = cmp.mapping.your_action()
})
```

### Snippet Expansion

Configure snippet behavior:

```lua
snippet = {
  expand = function(args)
    luasnip.lsp_expand(args.body)
  end,
}
```

## 🐛 Troubleshooting

### Completion Not Appearing

```vim
:checkhealth nvim-cmp    # Check nvim-cmp status
:CmpStatus               # Show completion source status
```

### LSP Completions Missing

```vim
:LspInfo                 # Check if LSP is attached
:lua print(vim.inspect(require('cmp').get_sources()))
```

### Snippets Not Working

```vim
:lua print(require('luasnip').available())  # List available snippets
```

### Performance Issues

- Reduce completion sources
- Increase keyword_length for buffer completions
- Disable ghost_text if needed

## 💡 Usage Tips

1. **Start typing** to see completions automatically
2. **Use Tab** for the most common workflow
3. **Learn snippet triggers** for your languages
4. **Use Ctrl+Space** when completions don't appear
5. **Navigate docs** with Ctrl+f/b for better understanding

## 🔗 Integration

### With LSP

- Completions automatically appear based on LSP capabilities
- Function signatures shown in documentation
- Import statements added automatically

### With Treesitter

- Better completion context through syntax understanding
- Accurate completion positioning

### With Telescope

- Completion sources can be searched and configured
- Integration with workspace symbols

---

**💡 Pro Tip**: Use `<Tab>` for most completion workflows - it handles completion selection, snippet expansion, and navigation intelligently!

_Intelligent completion - Making coding faster and more accurate_ ⚡
