return {
  -- The lazyvim.plugins.extras.lang.go extra (enabled in lazyvim.json) gives us
  -- gopls (completion/hover/goto/rename), Go treesitter, golangci-lint linting,
  -- DAP (delve) and neotest. We keep all of that but DISABLE formatting on Go.
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      -- Drop gofumpt/goimports that the go extra registers. No format-on-save,
      -- and `<leader>cf` / :Format become no-ops for Go buffers.
      opts.formatters_by_ft.go = {}
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          -- Belt-and-suspenders: even if something calls vim.lsp.buf.format(),
          -- gopls won't advertise itself as a formatter.
          on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },
      },
    },
  },
}
