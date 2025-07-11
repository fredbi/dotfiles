require("plugins.setup")

require("plugins.default")

require("plugins.lualine")
require("plugins.nvim-tree")
require("plugins.comment")
require("plugins.telescope")
require("plugins.nvim-treesitter")
require("plugins.gitsigns")
require("plugins.nvim-cmp")
require("plugins.catppuccin-theme")
require("plugins.barbar")
require("plugins.nvim-surround")
-- require("plugins.vim-mustache-handlebars")
-- vim.g.loaded_python3_provider=0
vim.g.loaded_ruby_provider=0
vim.g.loaded_julia_provider=0
vim.g.python3_host_prog="/usr/bin/python3"
vim.g.go_metalinter_enabled={}
vim.g.go_metalinter_command="golangci-lint run"
-- vim.g.go_metalinter_autosave=1
