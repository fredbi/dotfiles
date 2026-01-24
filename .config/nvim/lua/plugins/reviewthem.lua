-- change trouble config
return {
  "KEY60228/reviewthem.nvim",
  dependencies = {
    "sindrets/diffview.nvim", -- optional (need at least one diff tool)
    "KEY60228/alt-diffview", -- alternative diff tool
    "nvim-telescope/telescope.nvim", -- optional
  },
  config = function()
    require("reviewthem").setup({
      -- your configuration here
    })
  end,
}
