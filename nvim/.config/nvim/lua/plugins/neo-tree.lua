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
          added = "",
          deleted = "",
          modified = "",
          renamed = "",
          untracked = "",
          ignored = "",
          unstaged = "",
          staged = "",
          conflict = "",
        },
      },
      indent = {
        with_markers = false,
      },
    },
    event_handlers = {
      {
        event = "neo_tree_window_after_open",
        handler = function()
          local hl = vim.api.nvim_set_hl
          local explorer_bg = "#1E1F22"
          hl(0, "NeoTreeNormal", { bg = explorer_bg, fg = "#BCBEC4" })
          hl(0, "NeoTreeNormalNC", { bg = explorer_bg, fg = "#BCBEC4" })
          hl(0, "NeoTreeEndOfBuffer", { bg = explorer_bg, fg = explorer_bg })
          hl(0, "NeoTreeWinSeparator", { bg = explorer_bg, fg = explorer_bg })
          hl(0, "NeoTreeStatusLine", { bg = explorer_bg })
          hl(0, "WinSeparator", { bg = "NONE", fg = explorer_bg })
          hl(0, "NeoTreeGitIgnored", { fg = "#4E5157", italic = false })
          hl(0, "NeoTreeGitUntracked", { fg = "#6BCC62", italic = false })
          hl(0, "NeoTreeGitModified", { fg = "#E0CE70", italic = false })
          hl(0, "NeoTreeGitAdded", { fg = "#6BCC62", italic = false })
          hl(0, "NeoTreeGitDeleted", { fg = "#F27481", italic = false })
          hl(0, "NeoTreeGitConflict", { fg = "#F27481", italic = false, bold = true })
          hl(0, "NeoTreeGitRenamed", { fg = "#5594FA", italic = false })
          hl(0, "NeoTreeDotfile", { fg = "#6F737A", italic = false })
          hl(0, "NeoTreeHiddenByName", { fg = "#6F737A", italic = false })
          hl(0, "NeoTreeFileNameOpened", { fg = "#BCBEC4", italic = false, bold = true })
          hl(0, "NeoTreeDirectoryName", { fg = "#BCBEC4" })
          hl(0, "NeoTreeDirectoryIcon", { fg = "#5594FA" })
        end,
      },
    },
  },
}
