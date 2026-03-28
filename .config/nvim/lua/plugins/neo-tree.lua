return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    { "<C-h>", "<leader>e", desc = "Explorer NeoTree (Root Dir)", remap = true },
  },
  opts = function(_, opts)
    opts.filesystem = opts.filesystem or {}
    opts.filesystem.bind_to_cwd = false
    opts.filesystem.follow_current_file = { enabled = false }
    opts.filesystem.window = opts.filesystem.window or {}
    opts.filesystem.window.mappings = opts.filesystem.window.mappings or {}
    opts.filesystem.window.mappings["."] = "set_root"
  end,
}
