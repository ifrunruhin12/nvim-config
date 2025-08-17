# 🐛 Neovim Debugging Guide

> **Complete guide to debugging with nvim-dap, DAP-UI, and Go integration**

This guide covers everything you need to know about debugging in Neovim using the Debug Adapter Protocol (DAP) with a focus on Go development.

## 📋 Table of Contents

- [Overview](#overview)
- [Installation & Setup](#installation--setup)
- [Essential Keybindings](#essential-keybindings)
- [Debugging Go Applications](#debugging-go-applications)
- [DAP UI Components](#dap-ui-components)
- [Advanced Features](#advanced-features)
- [Troubleshooting](#troubleshooting)
- [Tips & Best Practices](#tips--best-practices)

## 🌟 Overview

Our debugging setup includes:

- **nvim-dap**: Core Debug Adapter Protocol client
- **nvim-dap-ui**: Beautiful debugging interface
- **nvim-dap-virtual-text**: Inline variable values
- **nvim-dap-go**: Go-specific debugging enhancements
- **mason-nvim-dap**: Automatic debugger installation
- **telescope-dap**: Telescope integration for debugging

### Visual Indicators

| Symbol | Meaning                     |
| ------ | --------------------------- |
| 🔴     | Standard breakpoint         |
| 🟡     | Conditional breakpoint      |
| 📝     | Log point                   |
| ▶️     | Current execution line      |
| ❌     | Rejected/invalid breakpoint |

## 🚀 Installation & Setup

### Prerequisites

1. **Go debugger (Delve)**: Automatically installed via Mason
2. **Go runtime**: Required for Go debugging
3. **Build tools**: For compiling debug versions

### Automatic Installation

The configuration automatically installs required debuggers through Mason:

```lua
-- Automatically installs delve (Go debugger)
ensure_installed = { "delve" }
```

### Manual Delve Installation (if needed)

```bash
# Install Delve manually
go install github.com/go-delve/delve/cmd/dlv@latest

# Verify installation
dlv version
```

## ⌨️ Essential Keybindings

### Core Debugging Controls

| Key     | Action    | Description                                     |
| ------- | --------- | ----------------------------------------------- |
| `<F5>`  | Continue  | Start/continue debugging                        |
| `<F10>` | Step Over | Execute current line, don't step into functions |
| `<F11>` | Step Into | Step into function calls                        |
| `<F12>` | Step Out  | Step out of current function                    |

### Breakpoint Management

| Key          | Action                 | Description                             |
| ------------ | ---------------------- | --------------------------------------- |
| `<leader>db` | Toggle Breakpoint      | Set/remove breakpoint on current line   |
| `<leader>dB` | Conditional Breakpoint | Set breakpoint with condition           |
| `<leader>lp` | Log Point              | Set log point (prints without stopping) |

### Session Management

| Key          | Action    | Description                     |
| ------------ | --------- | ------------------------------- |
| `<leader>dc` | Continue  | Continue execution              |
| `<leader>dt` | Terminate | Stop debugging session          |
| `<leader>dr` | REPL      | Open debug REPL                 |
| `<leader>dl` | Run Last  | Repeat last debug configuration |

### DAP UI Controls

| Key          | Action       | Description                       |
| ------------ | ------------ | --------------------------------- |
| `<leader>du` | Toggle UI    | Show/hide debugging interface     |
| `<leader>de` | Evaluate     | Evaluate expression under cursor  |
| `<leader>df` | Float Scopes | Show variables in floating window |

### Go-Specific Debugging

| Key           | Action          | Description                    |
| ------------- | --------------- | ------------------------------ |
| `<leader>dgt` | Debug Test      | Debug the Go test under cursor |
| `<leader>dgL` | Debug Last Test | Re-debug the last Go test      |

### Telescope Integration

| Key           | Action           | Description                     |
| ------------- | ---------------- | ------------------------------- |
| `<leader>dcc` | DAP Commands     | List all DAP commands           |
| `<leader>dco` | Configurations   | List debug configurations       |
| `<leader>dlb` | List Breakpoints | Show all breakpoints            |
| `<leader>dv`  | Variables        | Browse variables with Telescope |
| `<leader>df`  | Frames           | Browse stack frames             |

## 🏃‍♂️ Debugging Go Applications

### Quick Start

1. **Open your Go file**
2. **Set a breakpoint**: `<leader>db` on desired line
3. **Start debugging**: `<F5>` and select debug configuration
4. **Use the DAP UI** to inspect variables and control execution

### Available Go Configurations

When you press `<F5>`, you'll see these options:

1. **Debug** - Debug current file
2. **Debug (Arguments)** - Debug with command-line arguments
3. **Debug Package** - Debug entire package
4. **Debug Test** - Debug current test file
5. **Debug Test Package** - Debug all tests in package
6. **Attach to Process** - Attach to running Go process

### Debugging Examples

#### Example 1: Simple Program Debug

```go
// main.go
package main

import "fmt"

func main() {
    name := "World"
    message := fmt.Sprintf("Hello, %s!", name)  // Set breakpoint here
    fmt.Println(message)
}
```

**Steps:**

1. Place cursor on `message := ...` line
2. Press `<leader>db` to set breakpoint
3. Press `<F5>` and select "Debug"
4. Use `<F10>` to step over, `<F11>` to step into

#### Example 2: Test Debugging

```go
// math_test.go
package main

import "testing"

func TestAdd(t *testing.T) {
    result := Add(2, 3)  // Set breakpoint here
    if result != 5 {
        t.Errorf("Expected 5, got %d", result)
    }
}

func Add(a, b int) int {
    return a + b  // Another breakpoint here
}
```

**Steps:**

1. Place cursor in `TestAdd` function
2. Press `<leader>dgt` to debug specific test
3. Use stepping commands to trace execution

#### Example 3: Debugging with Arguments

```go
// app.go - expects command line arguments
package main

import (
    "fmt"
    "os"
)

func main() {
    if len(os.Args) < 2 {
        fmt.Println("Usage: app <name>")
        return
    }
    name := os.Args[1]  // Set breakpoint here
    fmt.Printf("Hello, %s!\n", name)
}
```

**Steps:**

1. Set breakpoint on `name := os.Args[1]`
2. Press `<F5>` and select "Debug (Arguments)"
3. Enter arguments: `John Doe`
4. Debug will start with those arguments

### Conditional Breakpoints

Set breakpoints that only trigger under specific conditions:

```go
for i := 0; i < 100; i++ {
    processItem(i)  // Set conditional breakpoint here
}
```

**Steps:**

1. Place cursor on the line
2. Press `<leader>dB`
3. Enter condition: `i > 50`
4. Breakpoint will only trigger when `i > 50`

### Log Points

Add logging without modifying your code:

```go
func calculateTotal(items []Item) float64 {
    total := 0.0
    for _, item := range items {
        total += item.Price  // Set log point here
    }
    return total
}
```

**Steps:**

1. Place cursor on `total += item.Price`
2. Press `<leader>lp`
3. Enter message: `Item: {item.Name}, Price: {item.Price}, Total: {total}`
4. Values will be printed to debug console without stopping

## 🖥️ DAP UI Components

### Layout Overview

The DAP UI opens automatically when debugging starts:

```
┌─────────────────┬─────────────────────────┐
│                 │                         │
│   Scopes        │                         │
│   Variables     │      Main Editor        │
│   Watches       │      (Your Code)        │
│   Breakpoints   │                         │
│   Stack Frames  │                         │
│                 │                         │
├─────────────────┴─────────────────────────┤
│              REPL / Console               │
│            (Debug Output)                 │
└───────────────────────────────────────────┘
```

### Scopes Panel

Shows variables in different scopes:

- **Local**: Function-level variables
- **Global**: Package-level variables
- **Arguments**: Function parameters

### Controls

Use the controls at the bottom of REPL:

- `` Play/Continue
- `` Pause
- `` Step Into
- `` Step Over
- `` Step Out
- `↻` Run Last
- `□` Terminate

### Interactive Features

In the DAP UI panels:

- `<CR>` or `o` - Expand/open item
- `d` - Remove item (breakpoints/watches)
- `e` - Edit item
- `r` - Open REPL
- `t` - Toggle item

## 🚀 Advanced Features

### Virtual Text

Shows variable values directly in your code:

```go
func example() {
    x := 42        // x = 42
    y := x * 2     // y = 84
    z := y + 10    // z = 94
}
```

Toggle with `<leader>dv`.

### Watch Expressions

Add expressions to monitor continuously:

1. In DAP UI, go to "Watches" section
2. Press `a` to add new watch
3. Enter expression like `len(mySlice)` or `user.Name`

### REPL Commands

In the debug REPL, you can:

- Evaluate expressions: `p variableName`
- Call functions: `call myFunction(arg1, arg2)`
- Set variables: `set myVar = newValue`

### Telescope Integration

Quickly navigate debugging elements:

- `<leader>dcc` - Browse all DAP commands
- `<leader>dlb` - Jump to any breakpoint
- `<leader>dv` - Search through variables

### Multiple Configurations

You can create custom debug configurations in your project:

```json
// .vscode/launch.json (also works with DAP)
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Debug with DB",
      "type": "go",
      "request": "launch",
      "program": "${workspaceFolder}/cmd/server",
      "env": {
        "DB_URL": "localhost:5432"
      },
      "args": ["--debug"]
    }
  ]
}
```

## 🔧 Troubleshooting

### Common Issues

#### 1. "dlv not found" Error

```bash
# Check if delve is installed
which dlv

# Install if missing
go install github.com/go-delve/delve/cmd/dlv@latest

# Add to PATH if needed
export PATH=$PATH:$(go env GOPATH)/bin
```

#### 2. Breakpoints Not Hit

- Ensure you're debugging (not just running) the code
- Check that the file is actually being executed
- Verify breakpoint is on an executable line
- Try rebuilding with debug symbols: `go build -gcflags="all=-N -l"`

#### 3. DAP UI Not Opening

```lua
-- Manually open DAP UI
:lua require("dapui").open()

-- Check if DAP is running
:lua print(vim.inspect(require("dap").session()))
```

#### 4. Variables Not Showing

- Make sure you're using Go with debug symbols
- Check that variables are in scope
- Try refreshing the DAP UI: `<leader>du` twice

### Debug Commands

Useful commands for troubleshooting:

```vim
:DapShowLog          " Show DAP logs
:DapToggleRepl       " Toggle REPL
:DapTerminate        " Force terminate session
:DapRestartFrame     " Restart current frame
```

### Performance Issues

If debugging is slow:

```lua
-- Disable virtual text temporarily
:lua require("nvim-dap-virtual-text").toggle()

-- Reduce DAP UI update frequency
require("dapui").setup({
  render = {
    max_value_lines = 50,  -- Reduce from default
    max_type_length = 50,
  },
})
```

## 💡 Tips & Best Practices

### 1. Efficient Breakpoint Management

- Use conditional breakpoints for loops: `i == 10`
- Use log points for tracing without stopping
- Clear old breakpoints regularly: `<leader>dlb` → select and delete

### 2. Smart Variable Inspection

- Use `<leader>de` on complex expressions
- Add watches for values that change frequently
- Use the hover feature: `<leader>dh`

### 3. Test Debugging Workflow

```go
// Best practice for debugging tests
func TestComplexLogic(t *testing.T) {
    // Set breakpoint on the test line you want to inspect
    result := ComplexFunction(input)

    // Use <leader>dgt to debug this specific test
    assert.Equal(t, expected, result)
}
```

### 4. Debugging Goroutines

```go
func main() {
    go func() {
        // Set breakpoint here
        fmt.Println("Goroutine running")
    }()

    time.Sleep(1 * time.Second)  // Breakpoint here too
}
```

Use "Attach to Process" configuration for running programs with goroutines.

### 5. Keyboard Shortcuts Memory Aid

Create a mental map:

- **F-keys**: Basic stepping (5=continue, 10=over, 11=into, 12=out)
- **`<leader>d`**: All debug commands
- **`<leader>db`**: Breakpoints
- **`<leader>du`**: UI toggle

### 6. Project-Specific Configuration

Create `.nvim/dap.lua` in your project root:

```lua
-- Project-specific DAP configuration
local dap = require("dap")

dap.configurations.go = vim.list_extend(dap.configurations.go, {
  {
    type = "delve",
    name = "Debug with Redis",
    request = "launch",
    program = "${workspaceFolder}/cmd/api",
    env = {
      REDIS_URL = "localhost:6379",
      DEBUG = "true"
    }
  }
})
```

### 7. Remote Debugging

For debugging applications running elsewhere:

```lua
{
  type = "delve",
  name = "Connect to Remote",
  request = "attach",
  mode = "remote",
  remotePath = "/path/on/remote",
  port = 38697,
  host = "127.0.0.1",
}
```

---

## 🎯 Quick Reference Card

### Most Used Commands

```
<F5>         - Start/Continue debugging
<leader>db   - Toggle breakpoint
<leader>du   - Toggle DAP UI
<F10>        - Step over
<F11>        - Step into
<leader>dt   - Terminate session
<leader>dgt  - Debug Go test
<leader>de   - Evaluate expression
```

### Emergency Commands

```
:DapTerminate    - Force stop debugging
:DapShowLog      - Show error logs
:FixLSP          - Restart LSP if needed
:Mason           - Check debugger installation
```

Happy debugging! 🐛➡️✨
