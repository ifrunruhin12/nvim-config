# 🤖 AI Assistant Setup Guide

This guide will help you set up intelligent AI features in your Neovim configuration, giving you a Cursor-like experience with code suggestions, chat, and AI-powered code actions.

## 📦 What's Included

### 1. **Codeium** - Intelligent Code Suggestions

- **Trigger**: Automatic suggestions as you type (when enabled)
- **Accept**: `Ctrl+G` (as requested)
- **Navigate**: `Ctrl+;` (next), `Ctrl+,` (previous)
- **Clear**: `Ctrl+X`
- **Toggle**: `<leader>ai` (enable), `<leader>dai` (disable)

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

Create these four new files in your `lua/plugins/` directory:

1. **`lua/plugins/ai-codeium.lua`** - Copy the Codeium configuration
2. **`lua/plugins/ai-chatgpt.lua`** - Copy the ChatGPT configuration
3. **`lua/plugins/ai-gen.lua`** - Copy the Gen.nvim configuration
4. **`lua/plugins/ai-trouble.lua`** - Copy the Trouble configuration

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
	-- AI PLUGINS (ADD THESE LINES)
	require("plugins.ai-codeium"),    -- AI code suggestions
	require("plugins.ai-chatgpt"),    -- ChatGPT integration
	require("plugins.ai-gen"),        -- Gen.nvim for AI actions
	require("plugins.ai-trouble"),    -- Trouble.nvim (dependency)
}
```

### Step 3: Update Lualine (Optional)

Replace your `lua/plugins/lualine.lua` with the updated version to show AI status in the status line.

### Step 4: Set Up API Keys

#### For ChatGPT:

1. Get an OpenAI API key from [https://platform.openai.com/api-keys](https://platform.openai.com/api-keys)
2. Add to your shell profile (`.bashrc`, `.zshrc`, etc.):

```bash
export OPENAI_API_KEY="your-api-key-here"
```

#### For Codeium (Free):

1. Codeium will prompt you to authenticate when first used
2. No API key needed - it's free!

#### For Gen.nvim (Local AI):

1. Install Ollama: [https://ollama.ai/](https://ollama.ai/)
2. Download a model: `ollama pull codellama:7b`
3. The plugin will auto-start Ollama when needed

## 🎮 Usage Guide

### Basic Workflow

1. **Start Coding**: Open a file and start writing code
2. **Enable AI**: Press `<leader>ai` to enable Codeium suggestions
3. **Get Suggestions**: As you type, you'll see AI suggestions
4. **Accept**: Press `Ctrl+G` to accept suggestions
5. **Chat**: Press `<leader>cc` to open AI chat for questions

### Key Bindings Summary

| Key           | Action     | Description                  |
| ------------- | ---------- | ---------------------------- |
| `<leader>ai`  | Enable AI  | Turn on Codeium suggestions  |
| `<leader>dai` | Disable AI | Turn off Codeium suggestions |
| `Ctrl+G`      | Accept     | Accept AI code suggestion    |
| `Ctrl+;`      | Next       | Next suggestion              |
| `Ctrl+,`      | Previous   | Previous suggestion          |
| `Ctrl+X`      | Clear      | Clear current suggestion     |

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

- 🤖✅ when AI is enabled
- 🤖❌ when AI is disabled

### Performance

- **Codeium**: Fast, cloud-based, free
- **ChatGPT**: Requires API key, pay-per-use
- **Gen.nvim**: Local, private, requires Ollama

## 🔍 Troubleshooting

### Codeium Not Working

1. Check internet connection
2. Try `:CodeiumAuth` to re-authenticate
3. Restart Neovim

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

- [Codeium Documentation](https://codeium.com/vim_tutorial)
- [ChatGPT.nvim GitHub](https://github.com/jackMort/ChatGPT.nvim)
- [Gen.nvim GitHub](https://github.com/David-Kunz/gen.nvim)
- [Ollama Models](https://ollama.ai/library)

---

🎉 **You now have a powerful AI-assisted development environment!** Start with `<leader>ai` to enable suggestions and `<leader>cc` to chat with AI about your code.
