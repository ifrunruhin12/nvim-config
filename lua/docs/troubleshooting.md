# 🛠️ Troubleshooting Guide

Complete troubleshooting guide for common issues with your Neovim configuration.

## 🚨 Quick Fixes

### Universal Solutions

```vim
:checkhealth            # Overall system health check
:Lazy sync              # Update/reinstall all plugins
:FixLSP                 # Restart all LSP clients (custom command)
:Mason                  # Check language server status
```

### Emergency Reset

```vim
# If Neovim won't start properly:
nvim --clean            # Start without any configuration
nvim -u NONE           # Start without plugins
```

## 🧠 LSP Issues

### LSP Not Starting

#### Symptoms

- No completions, diagnostics, or LSP features
- `:LspInfo` shows no attached clients

#### Solutions

```vim
:LspInfo                # Check if LSP is attached
:Mason                  # Verify language server is installed
:MasonInstall lua_ls    # Install specific server if missing
:FixLSP                 # Restart LSP clients
```

#### Manual Restart

```vim
:LspStop                # Stop all LSP clients
:LspStart               # Restart for current buffer
# Or restart Neovim
```

### Duplicate LSP Instances

#### Symptoms

- Multiple servers of same type in `:LspInfo`
- "Duplicate value" errors in logs
- Inconsistent LSP behavior

#### Solutions

```vim
:FixLSP                 # Custom command to clean duplicates
```

#### Manual Fix

```vim
:lua for _, client in pairs(vim.lsp.get_clients()) do client.stop() end
# Then restart Neovim
```

### LSP Server Not Found

#### Symptoms

- Mason shows server as not installed
- Error messages about missing executables

#### Solutions

```vim
:Mason                  # Open Mason UI
:MasonInstall <server>  # Install missing server
:MasonUpdate            # Update all servers
:MasonLog               # Check installation logs
```

#### System Dependencies

Some servers need system packages:

```bash
# Go tools
go install golang.org/x/tools/cmd/gopls@latest

# Python tools
pip install python-lsp-server

# Node.js tools
npm install -g typescript-language-server
```

### LSP Completions Not Working

#### Check LSP Status

```vim
:LspInfo                # Verify server is attached
:lua print(vim.inspect(vim.lsp.get_active_clients()))
```

#### Check nvim-cmp

```vim
:checkhealth nvim-cmp   # Health check for completion
:CmpStatus              # Show completion source status
```

## 💡 Autocompletion Issues

### No Completions Appearing

#### Check Sources

```vim
:lua print(vim.inspect(require('cmp').get_sources()))
```

#### Force Trigger

- Press `<C-Space>` to manually trigger
- Check if LSP is attached (`:LspInfo`)
- Verify file type is supported

### Completions Too Slow

#### Performance Tuning

```lua
-- In nvim-cmp config, reduce sources or add delays
sources = cmp.config.sources({
  { name = "nvim_lsp", priority = 1000 },
  { name = "buffer", priority = 500, keyword_length = 4 }, -- Higher minimum
})
```

### Snippets Not Expanding

#### Check LuaSnip

```vim
:lua print(require('luasnip').available())  # List available snippets
```

#### Debug Snippets

- Ensure snippets are loaded in `lua/snippets/init.lua`
- Check file type matches snippet language
- Try manual expansion: `:lua require('luasnip').expand()`

## 🔍 Telescope Issues

### No Files Found

#### Check Working Directory

```vim
:pwd                    # Check current directory
:cd /path/to/project    # Change if needed
```

#### File Patterns

```vim
# Check if files are hidden by ignore patterns
:Telescope find_files hidden=true
```

### Live Grep Not Working

#### Install ripgrep

```bash
# macOS
brew install ripgrep

# Ubuntu/Debian
sudo apt install ripgrep

# Windows
winget install BurntSushi.ripgrep.MSVC
```

#### Check Health

```vim
:checkhealth telescope  # Verify dependencies
```

### Telescope Performance Issues

#### Optimize Configuration

```lua
-- In telescope config
defaults = {
  file_ignore_patterns = { "node_modules", ".git/", "target/" },
  -- Add more patterns for large projects
}
```

## 🌲 Treesitter Issues

### Syntax Highlighting Broken

#### Update Parsers

```vim
:TSUpdate               # Update all parsers
:TSInstall <language>   # Install specific parser
```

#### Check Parser Status

```vim
:TSInstallInfo          # Show installation status
:checkhealth nvim-treesitter
```

### Parser Installation Fails

#### System Requirements

```bash
# Ensure you have a C compiler
# macOS:
xcode-select --install

# Ubuntu:
sudo apt install build-essential

# Windows:
# Install Visual Studio Build Tools
```

#### Manual Installation

```vim
:TSInstall! <language>  # Force reinstall
```

## 🎯 Formatting Issues

### Format on Save Not Working

#### Check none-ls Status

```vim
:NullLsInfo             # Show attached formatters
:checkhealth null-ls    # Health check
```

#### Check Autocommands

```vim
:autocmd BufWritePre    # Should show LspFormatting group
```

### Formatter Not Found

#### Install System Formatters

```bash
# Stylua for Lua
cargo install stylua

# Prettier for JS/TS
npm install -g prettier

# Black for Python
pip install black

# Check if installed
which stylua
which prettier
which black
```

### Format Conflicts

#### Multiple Formatters

If you have conflicts between LSP and none-ls:

```vim
:FixLSP                 # Should disable LSP formatting
```

#### Manual Fix

```lua
-- In LSP config, ensure this is set:
client.server_capabilities.documentFormattingProvider = false
```

## 📦 Plugin Issues

### Plugin Not Loading

#### Check Lazy Status

```vim
:Lazy                   # Open plugin manager
:Lazy log               # View installation logs
```

#### Force Reinstall

```vim
:Lazy clean             # Remove unused plugins
:Lazy sync              # Reinstall everything
```

### Plugin Errors on Startup

#### Safe Mode

```vim
nvim --clean            # Start without plugins
```

#### Debug Plugin

```vim
:messages               # View error messages
:Lazy profile           # See loading times
```

#### Check Dependencies

Ensure all plugin dependencies are installed and configured.

## ⚡ Performance Issues

### Slow Startup

#### Profile Plugins

```vim
:Lazy profile           # See plugin loading times
```

#### Identify Slow Plugins

- Look for plugins taking >50ms
- Consider lazy loading with `event`, `cmd`, or `keys`
- Remove unused plugins

### Slow LSP Performance

#### Reduce LSP Features

```lua
-- In LSP config, disable heavy features:
settings = {
  gopls = {
    analyses = {
      unusedparams = false,  -- Disable expensive analysis
    }
  }
}
```

#### Limit Workspace

```lua
-- In LSP config, limit workspace scanning:
settings = {
  gopls = {
    directoryFilters = { "-node_modules", "-vendor" },
  }
}
```

### High CPU Usage

#### Check Background Processes

```vim
:lua vim.print(vim.lsp.get_active_clients())  # Active LSP clients
:NullLsInfo                                   # Active none-ls sources
```

#### Disable Heavy Features

- Turn off real-time diagnostics: `update_in_insert = false`
- Reduce treesitter parsing for large files
- Limit completion sources

## 🌳 Neo-tree Issues

### Neo-tree Won't Open

#### Check Dependencies

```vim
:checkhealth neo-tree   # Verify dependencies installed
```

#### Manual Toggle

```vim
:Neotree toggle         # Try direct command
:Neotree filesystem     # Open filesystem view
```

### Git Status Not Showing

#### Check Git Repository

```bash
# Ensure you're in a git repository
git status              # Should show git info
```

#### Refresh Neo-tree

- Press `R` in Neo-tree to refresh
- Toggle and reopen Neo-tree

### File Operations Not Working

#### Check Permissions

- Ensure you have write permissions in directory
- Some operations may need elevated privileges

## 📱 Alpha Dashboard Issues

### Dashboard Not Appearing

#### Check Startup Conditions

```vim
# Dashboard should appear when starting without files
nvim                    # (no arguments)
```

#### Manual Open

```vim
:Alpha                  # Open dashboard manually
```

### Plugin Count Wrong

#### Update Stats

Dashboard updates automatically, but you can:

```vim
:Lazy sync              # Update plugins
:Alpha                  # Refresh dashboard
```

## 🔧 System-Level Issues

### Neovim Won't Start

#### Check Installation

```bash
nvim --version          # Verify Neovim is installed
which nvim              # Check location
```

#### Configuration Errors

```vim
nvim --clean            # Start without config
nvim -u ~/.config/nvim/init.lua  # Test config directly
```

#### Permission Issues

```bash
# Check config directory permissions
ls -la ~/.config/nvim/
chmod -R 755 ~/.config/nvim/  # Fix permissions if needed
```

### Plugin Installation Fails

#### Network Issues

```bash
# Test internet connection
curl -I https://github.com

# Check proxy settings if behind corporate firewall
```

#### Git Configuration

```bash
# Ensure git is configured
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Mason Installation Issues

#### System Dependencies

```bash
# Mason needs these tools
which curl              # For downloading
which unzip             # For extracting
which tar               # For extracting
which gzip              # For compression
which git               # For git repos
```

#### Manual Server Installation

Some servers can be installed manually:

```bash
# Go language server
go install golang.org/x/tools/cmd/gopls@latest

# Python language server
pip install python-lsp-server[all]

# Node.js language servers
npm install -g typescript-language-server
npm install -g vscode-langservers-extracted
```

## 🐍 Language-Specific Issues

### Go Issues

#### GOPATH/GOROOT Problems

```bash
echo $GOPATH            # Should show your Go workspace
echo $GOROOT            # Should show Go installation
go env                  # Show all Go environment variables
```

#### Module Issues

```bash
# In your Go project
go mod tidy             # Clean up modules
go mod download         # Download dependencies
```

### Python Issues

#### Virtual Environment

```bash
# LSP might not find packages in virtual environment
which python            # Check which Python is active
pip list                # See installed packages
```

#### Multiple Python Versions

LSP might use wrong Python version:

```lua
-- In lsp-config.lua, specify Python path:
settings = {
  python = {
    pythonPath = "/usr/bin/python3",  -- or your specific path
  }
}
```

### Lua Issues

#### Vim Global Warnings

If getting warnings about `vim` global in Lua files:

```vim
:LspInfo                # Check if lua_ls is running
```

Should be configured automatically, but you can check `.luarc.json`.

## 📋 Diagnostic Commands

### Health Checks

```vim
:checkhealth            # Full system check
:checkhealth lsp        # LSP-specific check
:checkhealth mason      # Mason package manager
:checkhealth nvim-cmp   # Completion system
:checkhealth telescope  # Telescope finder
:checkhealth treesitter # Syntax highlighting
:checkhealth neo-tree   # File explorer
```

### Information Commands

```vim
:version                # Neovim version and features
:messages               # Recent messages/errors
:LspInfo                # LSP server information
:Mason                  # Package manager UI
:Lazy                   # Plugin manager UI
:NullLsInfo            # Formatter/linter info
:TSInstallInfo         # Treesitter parser info
```

### Debug Commands

```vim
:lua vim.print(vim.lsp.get_active_clients())     # Active LSP clients
:lua vim.print(require('cmp').get_sources())     # Completion sources
:lua vim.print(package.loaded)                   # Loaded Lua modules
:set runtimepath?                                # Neovim search paths
```

## 🔄 Recovery Procedures

### Complete Reset

#### Backup and Reset

```bash
# Backup current config
mv ~/.config/nvim ~/.config/nvim.backup

# Fresh install
git clone <your-repo> ~/.config/nvim
nvim  # Let plugins install
```

#### Selective Reset

```bash
# Reset just plugins
rm -rf ~/.local/share/nvim/
rm -rf ~/.local/state/nvim/

# Reset just LSP servers
rm -rf ~/.local/share/nvim/mason/
```

### Plugin-Specific Reset

#### Reset Single Plugin

```vim
:Lazy clean             # Remove unused plugins
# Remove from config, restart, add back
```

#### Reset LSP Only

```vim
:FixLSP                 # Custom command to reset LSP
# Or manually:
:LspStop
:edit                   # Reload buffer
```

### Configuration Recovery

#### Git Recovery (if using version control)

```bash
cd ~/.config/nvim
git status              # Check changes
git checkout -- .      # Reset all changes
git log --oneline       # See commit history
git reset --hard HEAD~1  # Go back one commit
```

## 💡 Prevention Tips

### Regular Maintenance

```vim
# Weekly maintenance routine:
:checkhealth            # Check system health
:Lazy sync              # Update plugins
:Mason update           # Update language servers
:TSUpdate               # Update parsers
```

### Backup Strategy

```bash
# Create regular backups
cp -r ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d)

# Or use git
cd ~/.config/nvim
git add .
git commit -m "Working configuration $(date)"
```

### Monitoring Performance

```vim
:Lazy profile           # Check plugin loading times
# Look for plugins taking >100ms
```

## 🆘 Getting Help

### Log Files

```vim
:messages               # Neovim messages
:Lazy log               # Plugin installation logs
:MasonLog               # LSP server installation logs
:NullLsLog             # Formatter/linter logs
```

### Debug Information

When reporting issues, include:

- `:version` output
- `:checkhealth` results
- Error messages from `:messages`
- Steps to reproduce the issue

### Community Resources

- **Neovim Documentation**: `:help` command
- **Plugin Documentation**: Check GitHub repos
- **Community Forums**: Reddit r/neovim, Discord servers
- **GitHub Issues**: Report bugs to specific plugins

## 🎯 Common Error Messages

### "LSP client already attached"

**Solution**: `:FixLSP` or restart Neovim

### "Language server not found"

**Solution**: `:Mason` to install missing server

### "No completion available"

**Solution**: Check `:LspInfo` and `:CmpStatus`

### "Treesitter parser not found"

**Solution**: `:TSInstall <language>`

### "Plugin not found"

**Solution**: `:Lazy sync` to reinstall plugins

---

**💡 Pro Tip**: When troubleshooting, start with `:checkhealth` - it catches most common issues automatically!

_Troubleshooting made systematic - Get back to coding faster_ ⚡
