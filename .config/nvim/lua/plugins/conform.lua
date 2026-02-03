return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- Remove yaml from formatters_by_ft to disable auto-format
      -- We'll use manual formatting via keymap instead
    },
    formatters = {
      yamlfmt = {
        prepend_args = {
          "-formatter",
          "retain_line_breaks_single=true,max_line_length=0",
        },
      },
    },
  },
}
