return {
  {
    "folke/snacks.nvim",
    opts = {
      terminal = {
        win = {
          position = "bottom",
          height = 0.3,
        },
      },
      picker = {
        sources = {
          explorer = {
            hidden = true,
          },
          files = {
            hidden = true,
          },
          grep = {
            hidden = true,
          },
        },
      },
    },
  },
}
