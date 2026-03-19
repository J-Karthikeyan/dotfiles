return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      width = 30,
      mappings = {
        ["<space>"] = "none",
      },
    },
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
      },
      follow_current_file = {
        enabled = true,
      },
    },
    default_component_configs = {
      git_status = {
        symbols = {
          added = "+",
          deleted = "-",
          modified = "~",
          renamed = "r",
          untracked = "?",
          ignored = "i",
          unstaged = "U",
          staged = "S",
          conflict = "C",
        },
      },
    },
  },
}
