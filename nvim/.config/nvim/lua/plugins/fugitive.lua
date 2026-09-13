-- Fugitive: Git porcelain commands and editable diffs
-- Use :G for status, :Gvdiffsplit for editable side-by-side diffs

return {
  "tpope/vim-fugitive",
  cmd = {
    "Git",
    "G",
    "Gdiffsplit",
    "Gvdiffsplit",
    "Gread",
    "Gwrite",
    "Gclog",
    "Gllog",
  },
  keys = {
    { "<leader>gI", "<cmd>G<cr>", desc = "Git Status (Fugitive)" },
    { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git Commit" },
    { "<leader>gP", "<cmd>Git push<cr>", desc = "Git Push" },
    { "<leader>gl", "<cmd>Gclog<cr>", desc = "Git Log (Quickfix)" },
  },
}
