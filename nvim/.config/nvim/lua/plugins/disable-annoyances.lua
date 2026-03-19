-- Disable various notifications and UI elements that can be annoying

return {
  -- Disable noice notifications (use classic notifications)
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        view = "cmdline",
      },
      messages = {
        enabled = false,
      },
      popupmenu = {
        enabled = false,
      },
      notify = {
        enabled = false,
      },
    },
  },

  -- Disable nvim-notify completely
  {
    "rcarriga/nvim-notify",
    enabled = false,
  },
}
