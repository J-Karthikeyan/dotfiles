return {
  {
    "nickkadutskyi/jb.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("jb").setup({
        transparent = true,
      })
      vim.cmd("colorscheme jb")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "jb",
    },
  },
}
