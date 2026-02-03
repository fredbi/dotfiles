return {
  -- Current colorschemes
  { "ellisonleao/gruvbox.nvim" },
  { "folke/tokyonight.nvim" },
  { "catppuccin/nvim", name = "catppuccin" },

  -- Additional colorschemes for different light conditions
  { "sainnhe/everforest" }, -- Easy on eyes, good for long sessions
  { "rebelot/kanagawa.nvim" }, -- Warm, inspired by Japanese art
  { "EdenEast/nightfox.nvim" }, -- Multiple variants (dayfox for bright, nordfox, etc.)

  -- Configure LazyVim default
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
