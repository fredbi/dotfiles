-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Note: Go-specific keymaps are now in lua/plugins/go-nvim.lua

-- Go custom commands
vim.api.nvim_create_user_command("GoDef", function()
  vim.lsp.buf.definition()
end, { desc = "Go to definition" })

vim.api.nvim_create_user_command("GoDoc", function()
  vim.lsp.buf.hover()
end, { desc = "Show Go documentation" })

-- Theme switching commands for different light conditions
vim.api.nvim_create_user_command("ThemeDark", function()
  vim.cmd("colorscheme gruvbox")
  vim.o.background = "dark"
  print("Theme: Gruvbox Dark")
end, { desc = "Switch to dark theme (Gruvbox)" })

vim.api.nvim_create_user_command("ThemeLight", function()
  vim.cmd("colorscheme gruvbox")
  vim.o.background = "light"
  print("Theme: Gruvbox Light")
end, { desc = "Switch to light theme (Gruvbox Light)" })

vim.api.nvim_create_user_command("ThemeTokyo", function()
  vim.cmd("colorscheme tokyonight")
  print("Theme: Tokyo Night")
end, { desc = "Switch to Tokyo Night theme" })

vim.api.nvim_create_user_command("ThemeCat", function()
  vim.cmd("colorscheme catppuccin")
  print("Theme: Catppuccin")
end, { desc = "Switch to Catppuccin theme" })
