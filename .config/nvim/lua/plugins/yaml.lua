return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Ensure yamlls formatting is disabled
      opts.servers = opts.servers or {}
      opts.servers.yamlls = opts.servers.yamlls or {}
      opts.servers.yamlls.settings = opts.servers.yamlls.settings or {}
      opts.servers.yamlls.settings.yaml = opts.servers.yamlls.settings.yaml or {}
      opts.servers.yamlls.settings.yaml.format = {
        enable = false, -- Disable YAML LSP formatting
      }
      return opts
    end,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "yaml",
        callback = function(ev)
          -- Space + y + f to manually format YAML
          vim.keymap.set("n", "<leader>yf", function()
            require("conform").format({
              bufnr = ev.buf,
              formatters = { "yamlfmt" },
            })
            print("YAML formatted (arrays will be compacted)")
          end, { buffer = ev.buf, desc = "Format YAML file" })
        end,
      })
    end,
  },
}
