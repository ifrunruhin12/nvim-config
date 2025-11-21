# Terminal Functionality

## ToggleTerm Plugin

A powerful terminal plugin that provides IDE-like terminal functionality.

### Quick Toggle
- **`Ctrl + \`** - Quick toggle terminal (default horizontal split at bottom)

### Leader Key Commands
- **`<leader>tt`** - Toggle terminal (horizontal at bottom)
- **`<leader>tf`** - Toggle floating terminal (centered window)
- **`<leader>th`** - Toggle horizontal terminal (bottom split)
- **`<leader>tv`** - Toggle vertical terminal (side split)

### Terminal Mode Navigation
When inside the terminal:
- **`Esc`** - Exit terminal mode to normal mode
- **`Ctrl + h/j/k/l`** - Navigate between windows
- **`Ctrl + w`** - Window command prefix

### Resizing
- In normal mode, use standard vim window resize commands:
  - **`Ctrl + w` then `+`** - Increase height
  - **`Ctrl + w` then `-`** - Decrease height
  - **`Ctrl + w` then `>`** - Increase width
  - **`Ctrl + w` then `<`** - Decrease width
  - **`Ctrl + w` then `=`** - Equal size all windows

### Tips
- The terminal starts at 15 lines height by default
- Terminal persists its size between toggles
- You can have multiple terminals open (use `:2ToggleTerm` for terminal #2)
- Terminal closes automatically when the process exits
