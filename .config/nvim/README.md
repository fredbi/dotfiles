# Neovim Configuration - Keymaps Cheat Sheet

## Go Development

| Keymap | Command | Description |
|--------|---------|-------------|
| `Ctrl+D` | `:GoDef` | Go to definition |
| `K` | `:GoDoc` | Show documentation for symbol under cursor |
| `F2` | - | Toggle inlay hints (type annotations) on/off |

## Completion

| Keymap | Description |
|--------|-------------|
| `Enter` | Accept first/selected completion proposal |
| `Tab` | Cycle to next completion option |
| `Shift+Tab` | Cycle to previous completion option |

## Themes / Colorschemes

| Keymap | Command | Description |
|--------|---------|-------------|
| `Space+u+C` | - | Open colorscheme picker with live preview |
| - | `:ThemeDark` | Switch to Gruvbox Dark (low light) |
| - | `:ThemeLight` | Switch to Gruvbox Light (bright light) |
| - | `:ThemeTokyo` | Switch to Tokyo Night |
| - | `:ThemeCat` | Switch to Catppuccin |

**Available colorschemes:** gruvbox, tokyonight, catppuccin, everforest, kanagawa, nightfox (dayfox, nordfox, etc.)

## Markdown

| Keymap | Description |
|--------|-------------|
| `Space+m+p` | Preview Markdown in browser |

## YAML

| Keymap | Description |
|--------|-------------|
| `Space+y+f` | Manually format YAML file (arrays will be compacted) |

## Claude AI

| Keymap | Command | Description |
|--------|---------|-------------|
| `Space+a+c` | `:ClaudeCode` | Toggle Claude Code panel |
| `Space+a+f` | `:ClaudeCodeFocus` | Focus Claude Code panel |
| `Space+a+r` | `:ClaudeCode --resume` | Resume previous Claude session |
| `Space+a+C` | `:ClaudeCode --continue` | Continue current task with Claude |
| `Space+a+b` | `:ClaudeCodeAdd %` | Add current buffer to Claude's context |
| `Space+a+s` | `:ClaudeCodeSend` | Send selected text to Claude (visual mode) |
| `Space+a+a` | `:ClaudeCodeDiffAccept` | Accept Claude's suggested diff |
| `Space+a+d` | `:ClaudeCodeDiffDeny` | Deny Claude's suggested diff |

## General Settings

- **Line numbers:** Always visible in dark yellow (`#d79921`)
- **Leader key:** `Space` (default in LazyVim)

## Configuration Structure

```
~/.config/nvim/
├── init.lua                      # Entry point
├── lua/
│   ├── config/
│   │   ├── autocmds.lua         # Auto commands
│   │   ├── keymaps.lua          # Global keymaps and custom commands
│   │   ├── lazy.lua             # Lazy.nvim plugin manager setup
│   │   └── options.lua          # Editor options (line numbers, etc.)
│   └── plugins/
│       ├── colorschemes.lua     # Colorscheme configurations
│       ├── conform.lua          # Formatter configuration
│       ├── go-nvim.lua          # Go language support and keymaps
│       ├── markdown.lua         # Markdown preview
│       ├── mason.lua            # LSP/tool installer
│       ├── nvim-cmp.lua         # Completion configuration
│       ├── theme-switcher.lua   # Theme picker keymaps
│       └── yaml.lua             # YAML configuration
└── README.md                     # This file
```

## Notes

- **Auto-format on save:** Enabled for Go (goimports), YAML (can't be disabled)
- **Go file-specific keymaps:** Only active when editing `.go` files
- **YAML formatting:** Arrays are auto-formatted to compact style (`- item`) on save

---

Based on [LazyVim](https://github.com/LazyVim/LazyVim) - refer to the [documentation](https://lazyvim.github.io/installation) for more details.
