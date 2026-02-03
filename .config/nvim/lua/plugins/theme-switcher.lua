return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- Space+uC to open colorscheme picker
      {
        "<leader>uC",
        "<cmd>Telescope colorscheme enable_preview=true<cr>",
        desc = "Colorscheme picker with preview",
      },
    },
  },
}
