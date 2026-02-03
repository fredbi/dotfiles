return {
  "hrsh7th/nvim-cmp",
  dependencies = { "hrsh7th/cmp-emoji" },
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local cmp = require("cmp")

    table.insert(opts.sources, { name = "emoji" })

    -- Configure completion behavior
    opts.completion = opts.completion or {}
    opts.completion.completeopt = "menu,menuone,noinsert" -- Auto-select first item

    -- Configure keymaps
    opts.mapping = opts.mapping or {}
    opts.mapping["<CR>"] = cmp.mapping.confirm({ select = true }) -- Enter accepts first/selected item
    opts.mapping["<Tab>"] = cmp.mapping.select_next_item() -- Tab cycles to next
    opts.mapping["<S-Tab>"] = cmp.mapping.select_prev_item() -- Shift+Tab cycles to previous

    return opts
  end,
}
