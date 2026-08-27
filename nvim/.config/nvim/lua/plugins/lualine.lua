return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "kanagawa",
      },
      sections = {
        lualine_c = {
          { "filename", path = 2 },
        },
      },
    },
  },
}
