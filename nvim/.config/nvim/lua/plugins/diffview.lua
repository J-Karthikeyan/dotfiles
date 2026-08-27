-- Diffview: repository-wide review, history, and branch comparison
-- For daily hunk work, use gitsigns.nvim instead

return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewRefresh",
    "DiffviewFileHistory",
  },
  keys = {
    { "<leader>dv", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
    { "<leader>dh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History (current file)" },
    { "<leader>dH", "<cmd>DiffviewFileHistory<cr>", desc = "File History (repo)" },
    { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
    { "<leader>dr", "<cmd>DiffviewRefresh<cr>", desc = "Diffview Refresh" },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = { layout = "diff2_horizontal" },
      file_history = { layout = "diff2_horizontal" },
    },
    file_panel = {
      listing_style = "tree",
      win_config = { position = "left", width = 35 },
    },
    hooks = {
      diff_buf_read = function(bufnr)
        vim.opt_local.wrap = false
        vim.opt_local.list = false
        vim.opt_local.number = true
        vim.opt_local.relativenumber = false
      end,
    },
    keymaps = {
      disable_defaults = false,
    },
  },
}
