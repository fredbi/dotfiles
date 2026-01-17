if true then
  return {}
end
-- disabled for now
return {
  "ray-x/navigator.lua",
  dependencies = {
    { "ray-x/guihua.lua", run = "cd lua/guihua && make" },
    { "neovim/nvim-lspconfig" },
  },
  opts = {
    -- Basic configuration options
    lsp = {
      disable_lsp = false, -- Enable LSP integration
      signature_help = true, -- Enable signature help
      code_action = true, -- Enable code actions
    },
    mason = true, -- Integration with Mason LSP manager
    keymaps = {
      -- Example custom keymaps
      { key = "gd", func = "definition" },
      { key = "gD", func = "declaration" },
      { key = "gr", func = "references" },
    },
    treesitter = {
      enable = true, -- Enable treesitter integration
    },
  },
  config = function(_, opts)
    require("navigator").setup(opts)
  end,
}
