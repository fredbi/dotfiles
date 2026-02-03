# Neovim Configuration Guide - Lessons Learned

This document captures key learnings and patterns from configuring LazyVim for a Go/Markdown/YAML workflow.

## Key Configuration Patterns

### Plugin Configuration Structure

LazyVim uses a modular plugin system. Each file in `lua/plugins/*.lua` is automatically loaded:

```lua
-- lua/plugins/my-plugin.lua
return {
  "author/plugin-name",
  opts = {
    -- Plugin options
  },
  keys = {
    -- Keymaps specific to this plugin
  },
}
```

### File-Type Specific Keymaps

**Pattern that works reliably:**
Place keymaps in the plugin config file that loads for that filetype:

```lua
-- lua/plugins/go-nvim.lua
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function(ev)
    vim.keymap.set("n", "<C-d>", vim.lsp.buf.definition, {
      buffer = ev.buf,  -- Use ev.buf, not true
      desc = "Go to definition"
    })
  end,
})
```

**Why this works:**
- Loaded with the plugin, ensuring correct timing
- `buffer = ev.buf` properly scopes the keymap
- Keymaps only active when editing Go files

**What didn't work:**
- Setting keymaps in `lua/config/keymaps.lua` with `buffer = true` had timing issues
- The VeryLazy event was too late for LSP keymaps

### LSP Configuration

#### Disabling LSP Formatting

For yamlls and other LSP servers, use the `opts` function pattern to merge settings:

```lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.yamlls = opts.servers.yamlls or {}
      opts.servers.yamlls.settings = {
        yaml = {
          format = {
            enable = false,  -- Disable auto-format
          },
        },
      }
      return opts
    end,
  },
}
```

**Why the function pattern:**
LazyVim's extras may set default values. Using a function ensures proper merging instead of overwriting.

### Formatter Configuration (conform.nvim)

**Disabling auto-format for specific filetypes:**

```lua
-- lua/plugins/conform.lua
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- Simply omit the filetype to disable auto-format
      -- yaml = {},  -- Don't include this
    },
  },
}
```

**Important:** Don't set `format_on_save` in opts - LazyVim manages this automatically.

**Manual formatting with keymap:**

```lua
vim.keymap.set("n", "<leader>yf", function()
  require("conform").format({
    bufnr = vim.api.nvim_get_current_buf(),
    formatters = { "yamlfmt" }
  })
end, { desc = "Format YAML manually" })
```

### Completion Configuration

To auto-select the first completion item:

```lua
-- lua/plugins/nvim-cmp.lua
opts = function(_, opts)
  local cmp = require("cmp")

  opts.completion = opts.completion or {}
  opts.completion.completeopt = "menu,menuone,noinsert"  -- Key setting

  opts.mapping = opts.mapping or {}
  opts.mapping["<CR>"] = cmp.mapping.confirm({ select = true })

  return opts
end
```

### Inlay Hints Toggle

**Working pattern for Neovim 0.12.0-dev:**

```lua
vim.keymap.set("n", "<F2>", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
  vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = bufnr })
  print("Inlay hints: " .. (is_enabled and "OFF" or "ON"))
end, { buffer = ev.buf, desc = "Toggle inlay hints" })
```

**Key learnings:**
- Pass `{ bufnr = bufnr }` to both `is_enabled()` and `enable()`
- Add debug print statements to verify toggle is working
- The API changed between Neovim versions

## Troubleshooting Patterns

### When Keymaps Don't Work

1. **Check if the autocmd fires:**
   ```lua
   callback = function(ev)
     print("Autocmd triggered!")  -- Debug message
     -- Your keymaps here
   end
   ```

2. **Verify the filetype:**
   ```vim
   :set filetype?
   ```

3. **Check for conflicts:**
   - Ctrl+T conflicts with tag stack (native Vim)
   - Ctrl+L conflicts with screen redraw
   - Use function keys (F2, F3, etc.) or leader key mappings for safety

4. **Location matters:**
   - FileType-specific keymaps → Put in plugin config
   - Global keymaps → Can go in `lua/config/keymaps.lua`
   - Go keymaps specifically needed to be in go-nvim.lua plugin config

### When Auto-Format Won't Disable

LazyVim's extras can re-enable formatting. Check:

1. **What extras are loaded:**
   ```json
   // lazyvim.json
   {
     "extras": [
       "lazyvim.plugins.extras.lang.yaml",  // This enables formatting
     ]
   }
   ```

2. **Override in plugin config:**
   Use `opts = function(_, opts)` pattern to properly merge settings

3. **Check both sources:**
   - conform.nvim formatter
   - LSP server formatting (yamlls, gopls, etc.)

### Inlay Hints Issues

If toggle only works one way:
- Check the API signature for your Neovim version
- Verify you're passing bufnr correctly
- Add debug prints to see current state
- Try explicit if/else instead of `not` operator

## Common Vim/Neovim Concepts

### Leader Key
- Usually Space in LazyVim
- Check with `:echo mapleader`
- Used as prefix for custom keymaps: `<leader>yf` = Space+y+f

### Buffer vs Window vs Tab
- **Buffer** = File in memory
- **Window** = Viewport showing a buffer
- **Tab** = Collection of windows
- Use `buffer = ev.buf` for buffer-local keymaps

### Normal vs Insert vs Visual Mode
- **Normal mode** (n) = Navigation and commands
- **Insert mode** (i) = Text editing
- **Visual mode** (v) = Text selection
- Keymaps are mode-specific: `vim.keymap.set("n", ...)`

## Best Practices Discovered

1. **Always read files before editing:**
   - Use Read tool first to see current state
   - Understand existing patterns before changing

2. **Use debug messages during development:**
   ```lua
   print("Debug: Feature triggered!")
   ```
   Remove them once working

3. **Restart Neovim after plugin changes:**
   - `:source $MYVIMRC` doesn't always work for plugins
   - Full restart ensures clean state

4. **Check LazyVim extras:**
   - They provide good defaults but may conflict with custom configs
   - Review the extra's source code when troubleshooting

5. **Use telescope for discovery:**
   - `Space+u+C` for colorschemes
   - `Space+f+f` for files
   - `Space+s+k` for keymaps

6. **File organization:**
   ```
   lua/config/     → Core settings, global keymaps
   lua/plugins/    → Plugin-specific configs
   ```

## YAML Formatting Limitation

**Issue:** Standard YAML formatters don't support block-style arrays with dash on separate line:
```yaml
# Desired but not supported by formatters:
array:
  -
    item1
  -
    item2
```

**Why:** Formatters normalize to standard compact style:
```yaml
array:
  - item1
  - item2
```

**Solution:** Disable auto-format and use manual formatting sparingly

**Research notes:**
- yamlfmt, prettier, yamlfix all normalize to compact style
- `indentless_arrays` only controls indentation level, not style
- Popular repos maintain this style manually without formatters

## Tool Installation

Mason manages LSP servers and tools:

```lua
-- lua/plugins/mason.lua
return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "yamlfmt",
      "gopls",
      -- etc.
    },
  },
}
```

Tools are installed to `~/.local/share/nvim/mason/`

## Color Customization

Set highlight groups for UI elements:

```lua
-- Line numbers
vim.api.nvim_set_hl(0, "LineNr", { fg = "#d79921" })

-- Use :Telescope highlights to browse all highlight groups
```

## Plugin Dependencies

Some plugins need build steps:

```lua
{
  "iamcco/markdown-preview.nvim",
  build = function(plugin)
    vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
  end,
}
```

If build fails, manually run:
```bash
cd ~/.local/share/nvim/lazy/markdown-preview.nvim/app
npx --yes yarn install
```

## Resources

- [LazyVim Documentation](https://lazyvim.github.io)
- [Neovim LSP Documentation](https://neovim.io/doc/user/lsp.html)
- [conform.nvim](https://github.com/stevearc/conform.nvim)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)

## Version Tested

- Neovim: v0.12.0-dev
- LazyVim: Latest (as of Jan 2025)
- OS: Linux

---

*This guide was created during a customization session focused on Go development, Markdown editing, and YAML file management.*
