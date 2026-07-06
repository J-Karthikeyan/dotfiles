return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = false,
      },
      servers = {
        r_language_server = {
          -- nvim 0.11+ passes bufnr (number) instead of fname (string); resolve
          -- it to the buffer's path before handing to vim.fs.find.
          root_dir = function(bufnr_or_fname)
            local fname = type(bufnr_or_fname) == "number"
              and vim.api.nvim_buf_get_name(bufnr_or_fname)
              or bufnr_or_fname
            -- First try to find .lintr file
            local lintr_dir = vim.fs.dirname(vim.fs.find(".lintr", { path = fname, upward = true })[1])
            if lintr_dir then
              return lintr_dir
            end
            -- Fall back to git root
            local git_root = vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
            if git_root then
              return git_root
            end
            -- Finally fall back to home directory
            return vim.uv.os_homedir()
          end,
          settings = {
            r = {
              lsp = {
                diagnostics = true,
                lint_cache = false,
              },
            },
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.typescript = { "prettier" }
      opts.formatters_by_ft.javascript = { "prettier" }
      opts.formatters_by_ft.typescriptreact = { "prettier" }
      opts.formatters_by_ft.javascriptreact = { "prettier" }

      opts.formatters = opts.formatters or {}
      opts.formatters.prettier = {
        prepend_args = { "--tab-width", "4" },
      }
    end,
  },
}
