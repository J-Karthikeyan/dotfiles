-- TEMPORARY: just to preview Gruvbox Hard Dark.
-- Delete this file when done evaluating.
return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 999, -- below kanagawa so it doesn't auto-apply
    opts = {
      contrast = "hard",
      transparent_mode = true,
    },
  },
}
