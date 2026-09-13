-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- Calmer yank highlight. LazyVim's default uses IncSearch which kanagawa-dragon
-- paints in a bright orange that flashes too aggressively. Replace with a
-- subtle selection-blue from the kanagawa-dragon palette.
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#2D4F67", fg = "#c5c9c5" })
  end,
})
vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#2D4F67", fg = "#c5c9c5" })

pcall(vim.api.nvim_del_augroup_by_name, "lazyvim_highlight_yank")
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("custom_highlight_yank", { clear = true }),
  callback = function()
    (vim.hl or vim.highlight).on_yank({ higroup = "YankHighlight", timeout = 200 })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "typescript", "typescriptreact", "haskell", "lhaskell", "cabal" },
  callback = function()
    vim.b.autoformat = false
  end,
})
