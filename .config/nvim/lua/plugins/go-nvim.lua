return {
  "ray-x/go.nvim",
  dependencies = { -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("go").setup({
      -- lsp_keymaps = false,
      -- other options
    })

    -- Format on save
    local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
        require("go.format").goimports()
      end,
      group = format_sync_grp,
    })

    -- Go-specific keymaps
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "go",
      callback = function(ev)
        print("Go keymaps loaded!")
        -- Ctrl+D to go to definition
        vim.keymap.set("n", "<C-d>", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })

        -- K to show documentation hover
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Show documentation" })

        -- F2 to toggle inlay hints
        vim.keymap.set("n", "<F2>", function()
          print("F2 pressed!")
          local bufnr = vim.api.nvim_get_current_buf()
          local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
          vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = bufnr })
          print("Inlay hints: " .. (is_enabled and "OFF" or "ON"))
        end, { buffer = ev.buf, desc = "Toggle inlay hints" })
      end,
    })
  end,
  event = { "CmdlineEnter" },
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}
