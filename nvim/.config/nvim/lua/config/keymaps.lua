-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result + center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search result + center" })

-- Force <leader>fg to be live_grep (override LazyVim's git_files default)
pcall(vim.keymap.del, "n", "<leader>fg")
vim.keymap.set("n", "<leader>fg", function()
  require("telescope.builtin").live_grep({ additional_args = { "--hidden" } })
end, { desc = "Live Grep (includes hidden)" })

-- Focus Neo-tree sidebar if open
vim.keymap.set("n", "<leader>E", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == "neo-tree" then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
  vim.cmd("Neotree focus")
end, { desc = "Focus File Explorer" })

-- =============================================================================
-- GIT MERGE CONFLICT RESOLUTION
-- =============================================================================

-- Show merge conflicts
vim.keymap.set("n", "<leader>gc", "<cmd>GitConflictListQf<cr>", { desc = "List git conflicts" })

-- Navigate conflicts
vim.keymap.set("n", "]x", "<cmd>GitConflictNextConflict<cr>", { desc = "Next conflict" })
vim.keymap.set("n", "[x", "<cmd>GitConflictPrevConflict<cr>", { desc = "Previous conflict" })

-- Choose conflict sides (similar to git checkout --ours/--theirs)
vim.keymap.set("n", "<leader>co", "<cmd>GitConflictChooseOurs<cr>", { desc = "Choose OURS" })
vim.keymap.set("n", "<leader>ct", "<cmd>GitConflictChooseTheirs<cr>", { desc = "Choose THEIRS" })
vim.keymap.set("n", "<leader>cb", "<cmd>GitConflictChooseBoth<cr>", { desc = "Choose BOTH" })
vim.keymap.set("n", "<leader>c0", "<cmd>GitConflictChooseNone<cr>", { desc = "Choose NONE" })

-- Quick git actions
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "Open LazyGit" })
