-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Yank current file path to system clipboard. Shows a brief confirmation so
-- you know what landed in the clipboard.
local function yank_path(modifier, label)
  local path = vim.fn.expand("%:" .. modifier)
  vim.fn.setreg("+", path)
  vim.notify(label .. ": " .. path, vim.log.levels.INFO)
end

vim.keymap.set("n", "<leader>yp", function() yank_path("p", "abs") end,
  { desc = "Yank absolute path" })
vim.keymap.set("n", "<leader>yr", function() yank_path(".", "rel") end,
  { desc = "Yank relative path" })
vim.keymap.set("n", "<leader>yn", function() yank_path("t", "name") end,
  { desc = "Yank file name" })
vim.keymap.set("n", "<leader>yd", function() yank_path("p:h", "dir") end,
  { desc = "Yank parent directory" })
