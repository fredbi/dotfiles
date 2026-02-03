-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Enable line numbers
vim.opt.number = true -- Show absolute line numbers
vim.opt.relativenumber = false -- Use absolute numbers instead of relative

-- Set line number color to dark yellow
vim.api.nvim_set_hl(0, "LineNr", { fg = "#d79921" }) -- Dark yellow color
