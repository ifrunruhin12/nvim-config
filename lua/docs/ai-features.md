# 🤖 AI Assistant Setup Guide

This guide will help you set up intelligent AI features in your Neovim configuration, giving you a Cursor-like experience with code suggestions, chat, and AI-powered code actions.

## 📦 What's Included

### 1. **GitHub Copilot** - Intelligent Code Suggestions

- **Trigger**: Automatic suggestions as you type (when enabled)
- **Accept**: `Ctrl+G` (as configured)
- **Navigate**: `Ctrl+;` (next), `Ctrl+,` (previous)
- **Clear**: `Ctrl+X`
- **Enable/Disable/Toggle**: `<leader>ai` (enable), `<leader>dai` (disable), `<leader>tai` (toggle)

### 2. **ChatGPT** - AI Chat & Code Actions

- **Chat**: `<leader>cc` - Open ChatGPT chat sidebar
- **Edit**: `<leader>ce` - Edit code with instructions
- **Explain**: `<leader>cx` - Explain selected code
- **Optimize**: `<leader>co` - Optimize code
- **Fix**: `<leader>cf` - Fix bugs
- **Tests**: `<leader>ca` - Generate tests

### 3. **Gen.nvim** - Local AI with Ollama

- **Menu**: `<leader>]` - Open AI actions menu
- **Explain**: `<leader>ge` - Explain code
- **Fix**: `<leader>gf` - Fix code
- **Optimize**: `<leader>go` - Optimize code

## 🚀 Installation Steps

### Step 1: Create Plugin Files

Create these files in your `lua/plugins/` directory:

1. **`lua/plugins/ai-copilot.lua`** - GitHub Copilot configuration
2. **`lua/plugins/ai-chatgpt.lua`** - ChatGPT configuration
3. **`lua/plugins/ai-gen.lua`** - Gen.nvim configuration
4. **`lua/plugins/ai-trouble.lua`** - Trouble configuration

### Step 2: Update Plugin Initialization

Add these lines to your `lua/plugins/init.lua`:

```lua
return {
	require("plugins.colorscheme"),
	require("plugins.devicons"),
	require("plugins.neo-tree"),
	require("plugins.nui"),
	require("plugins.plenary"),
	require("plugins.telescope"),
	require("plugins.treesitter"),
	require("plugins.lualine"),
	require("plugins.lsp-config"),
	require("plugins.none-ls"),
	require("plugins.alpha"),
	require("plugins.nvim-cmp"),
	require("plugins.autopairs"),
	-- AI PLUGINS
	-- require("plugins.ai-codeium"),    -- old (removed)
	require("plugins.ai-chatgpt"),    -- ChatGPT integration
	require("plugins.ai-gen"),        -- Gen.nvim for AI actions
	require("plugins.ai-trouble"),    -- Trouble.nvim (dependency)
	require("plugins.ai-copilot"),    -- GitHub Copilot code suggestions
}
```

### Step 3: Update Lualine (Optional)

Replace your `lua/plugins/lualine.lua` with the updated version to show AI status in the status line.

### Step 4: Set Up Authentication / API Keys

#### For GitHub Copilot:

1. Run `:Copilot setup` to authenticate with GitHub
2. Check status with `:Copilot status`

#### For ChatGPT:

1. Get an OpenAI API key from https://platform.openai.com/api-keys
2. Add to your shell profile (`.bashrc`, `.zshrc`, etc.):

```bash
export OPENAI_API_KEY="your-api-key-here"
```

#### For Gen.nvim (Local AI):

1. Install Ollama: https://ollama.ai/
2. Download a model: `ollama pull codellama:7b`
3. The plugin will auto-start Ollama when needed

## 🎮 Usage Guide

### Basic Workflow

1. **Start Coding**: Open a file and start writing code
2. **Enable AI**: Press `<leader>ai` to enable Copilot suggestions
3. **Get Suggestions**: As you type, you'll see AI suggestions
4. **Accept**: Press `Ctrl+G` to accept suggestions
5. **Chat**: Press `<leader>cc` to open AI chat for questions

### Key Bindings Summary

| Key           | Action      | Description                   |
| ------------- | ----------- | ----------------------------- |
| `<leader>ai`  | Enable AI   | Turn on Copilot suggestions   |
| `<leader>dai` | Disable AI  | Turn off Copilot suggestions  |
| `<leader>tai` | Toggle AI   | Toggle Copilot on/off         |
| `Ctrl+G`      | Accept      | Accept AI code suggestion     |
| `Ctrl+;`      | Next        | Next suggestion               |
| `Ctrl+,`      | Previous    | Previous suggestion           |
| `Ctrl+X`      | Clear       | Clear current suggestion      |

### Chat & Code Actions

| Key          | Action   | Description           |
| ------------ | -------- | --------------------- |
| `<leader>cc` | Chat     | Open ChatGPT chat     |
| `<leader>ce` | Edit     | Edit with instruction |
| `<leader>cx` | Explain  | Explain code          |
| `<leader>co` | Optimize | Optimize code         |
| `<leader>cf` | Fix      | Fix bugs              |
| `<leader>ca` | Tests    | Add tests             |
| `<leader>ch` | Help     | Show ChatGPT commands |

### Gen.nvim (Local AI)

| Key          | Action   | Description           |
| ------------ | -------- | --------------------- |
| `<leader>]`  | Menu     | Open AI actions menu  |
| `<leader>ge` | Explain  | Explain code locally  |
| `<leader>gf` | Fix      | Fix code locally      |
| `<leader>go` | Optimize | Optimize code locally |

## 🔧 Configuration Tips

### Disable Suggestions by Default

The AI suggestions are **disabled by default** to avoid interfering with your thought process. Enable them only when needed with `<leader>ai`.

### Status Indicator

Look at your status line - you'll see:

- 🤖✅ when Copilot is enabled
- 🤖❌ when Copilot is disabled

### Performance

- **GitHub Copilot**: Fast, cloud-based (requires GitHub account)
- **ChatGPT**: Requires API key, pay-per-use
- **Gen.nvim**: Local, private, requires Ollama

## 🔍 Troubleshooting

### GitHub Copilot Not Working

1. Run `:Copilot setup` to authenticate
2. Check status with `:Copilot status`
3. Ensure internet connectivity
4. Restart Neovim

### ChatGPT Not Working

1. Verify `OPENAI_API_KEY` environment variable
2. Check API key permissions
3. Restart terminal/Neovim

### Gen.nvim Not Working

1. Install Ollama: `curl -fsSL https://ollama.ai/install.sh | sh`
2. Pull model: `ollama pull codellama:7b`
3. Check if Ollama is running: `ollama list`

### Plugin Installation Issues

1. Restart Neovim completely
2. Run `:Lazy sync` to update plugins
3. Check for error messages with `:checkhealth`

## 🚀 Advanced Usage

### Custom Prompts

You can add custom prompts to Gen.nvim by modifying the configuration:

```lua
require('gen').prompts['Your_Custom_Prompt'] = {
  prompt = "Your custom prompt here: $text",
  replace = true
}
```

### ChatGPT Custom Actions

Create custom ChatGPT actions by adding them to the actions_paths in the configuration.

### Multiple Models

You can switch between different Ollama models by changing the model parameter in Gen.nvim configuration.

## 📚 Resources

- [GitHub Copilot for Neovim (copilot.vim)](https://github.com/github/copilot.vim)
- [ChatGPT.nvim GitHub](https://github.com/jackMort/ChatGPT.nvim)
- [Gen.nvim GitHub](https://github.com/David-Kunz/gen.nvim)
- [Ollama Models](https://ollama.ai/library)

---

🎉 **You now have a powerful AI-assisted development environment!** Start with `<leader>ai` to enable Copilot suggestions and `<leader>cc` to chat with AI about your code.
