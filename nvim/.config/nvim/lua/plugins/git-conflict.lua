-- Git Conflict: inline merge conflict resolution
-- Keymaps use <leader>x prefix, ]x/[x for navigation

return {
  "akinsho/git-conflict.nvim",
  version = "*",
  event = "BufReadPre",
  opts = {
    default_mappings = false,
    default_commands = true,
    disable_diagnostics = true,
    list_opener = "copen",
    highlights = {
      incoming = "DiffAdd",
      current = "DiffText",
    },
  },
  keys = {
    { "<leader>xo", "<cmd>GitConflictChooseOurs<cr>", desc = "Choose Ours" },
    { "<leader>xt", "<cmd>GitConflictChooseTheirs<cr>", desc = "Choose Theirs" },
    { "<leader>xb", "<cmd>GitConflictChooseBoth<cr>", desc = "Choose Both" },
    { "<leader>xn", "<cmd>GitConflictChooseNone<cr>", desc = "Choose None" },
    { "]x", "<cmd>GitConflictNextConflict<cr>", desc = "Next Conflict" },
    { "[x", "<cmd>GitConflictPrevConflict<cr>", desc = "Prev Conflict" },
    { "<leader>xq", "<cmd>GitConflictListQf<cr>", desc = "Send Conflicts to Quickfix" },
  },
}
