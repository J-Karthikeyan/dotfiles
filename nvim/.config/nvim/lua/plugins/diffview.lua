return {
  "sindrets/diffview.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewRefresh",
    "DiffviewFileHistory",
    "DiffviewLog",
  },
  keys = {
    -- Open diff view
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open DiffView" },
    -- Close diff view
    { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Close DiffView" },
    -- Toggle file panel
    { "<leader>gt", "<cmd>DiffviewToggleFiles<cr>", desc = "Toggle Diff Files" },
    -- Focus file panel
    { "<leader>gf", "<cmd>DiffviewFocusFiles<cr>", desc = "Focus Diff Files" },
    -- Refresh
    { "<leader>gr", "<cmd>DiffviewRefresh<cr>", desc = "Refresh DiffView" },
    -- File history for current file
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History (current)" },
    -- Full repo file history
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "File History (repo)" },
    -- Conflict resolution
    { "<leader>gC", "<cmd>DiffviewOpen --merge<cr>", desc = "Open Merge Conflicts" },
  },
  opts = {
    diff_binaries = false,
    enhanced_diff_hl = true,
    git_cmd = { "git" },
    use_icons = true,
    icons = {
      folder_closed = "",
      folder_open = "",
    },
    signs = {
      fold_closed = "",
      fold_open = "",
      done = "✓",
    },
    view = {
      -- Use default "diff2_horizontal" for side-by-side
      -- Available layouts: "diff2_horizontal", "diff2_vertical", "diff3_horizontal",
      --                    "diff3_vertical", "diff3_mixed", "diff4_mixed"
      default = {
        -- Show files in a sidebar
        layout = "diff2_horizontal",
        winbar_info = false,
      },
      merge_tool = {
        -- Config for conflicted files in diff views during a merge
        layout = "diff3_horizontal",
        disable_diagnostics = true,
        winbar_info = true,
      },
      file_history = {
        -- Config for file_history views
        layout = "diff2_horizontal",
        winbar_info = false,
      },
    },
    file_panel = {
      listing_style = "tree",
      tree_options = {
        flatten_dirs = true,
        folder_statuses = "only_folded",
      },
      win_config = {
        position = "left",
        width = 35,
        win_opts = {},
      },
    },
    file_history_panel = {
      log_options = {
        git = {
          single_file = {
            diff_merges = "combined",
          },
          multi_file = {
            diff_merges = "first-parent",
          },
        },
      },
      win_config = {
        position = "bottom",
        height = 16,
        win_opts = {},
      },
    },
    commit_log_panel = {
      win_config = {},
    },
    default_args = {
      DiffviewOpen = {},
      DiffviewFileHistory = {},
    },
    hooks = {
      -- Pre-configure diff buffers before rendering
      diff_buf_read = function(bufnr)
        -- Enable word diff highlighting
        vim.opt_local.wrap = false
        vim.opt_local.list = false
        vim.opt_local.relativenumber = false
        vim.opt_local.number = true
      end,
    },
    keymaps = {
      disable_defaults = false,
      view = {
        -- Use these keymaps in diff buffers
        ["<tab>"] = "select_next_entry",
        ["<s-tab>"] = "select_prev_entry",
        ["gf"] = "goto_file",
        ["<C-w><C-f>"] = "goto_file_split",
        ["<C-w>gf"] = "goto_file_tab",
        ["<leader>e"] = "focus_files",
        ["<leader>b"] = "toggle_files",
      },
      file_panel = {
        ["j"] = "next_entry",
        ["<down>"] = "next_entry",
        ["k"] = "prev_entry",
        ["<up>"] = "prev_entry",
        ["<cr>"] = "select_entry",
        ["o"] = "select_entry",
        ["<2-LeftMouse>"] = "select_entry",
        ["-"] = "toggle_stage_entry",
        ["S"] = "stage_all",
        ["U"] = "unstage_all",
        ["X"] = "restore_entry",
        ["R"] = "refresh_files",
        ["L"] = "open_commit_log",
        ["<c-b>"] = "scroll_view(-0.25)",
        ["<c-f>"] = "scroll_view(0.25)",
        ["<tab>"] = "select_next_entry",
        ["<s-tab>"] = "select_prev_entry",
        ["gf"] = "goto_file",
        ["<C-w><C-f>"] = "goto_file_split",
        ["<C-w>gf"] = "goto_file_tab",
        ["i"] = "listing_style",
        ["f"] = "toggle_flatten_dirs",
        ["<leader>e"] = "focus_files",
        ["<leader>b"] = "toggle_files",
      },
      file_history_panel = {
        ["g!"] = "options",
        ["<C-A-d>"] = "open_in_diffview",
        ["y"] = "copy_hash",
        ["L"] = "open_commit_log",
        ["zR"] = "open_all_folds",
        ["zM"] = "close_all_folds",
        ["j"] = "next_entry",
        ["<down>"] = "next_entry",
        ["k"] = "prev_entry",
        ["<up>"] = "prev_entry",
        ["<cr>"] = "select_entry",
        ["o"] = "select_entry",
        ["<2-LeftMouse>"] = "select_entry",
        ["<c-b>"] = "scroll_view(-0.25)",
        ["<c-f>"] = "scroll_view(0.25)",
        ["<tab>"] = "select_next_entry",
        ["<s-tab>"] = "select_prev_entry",
        ["gf"] = "goto_file",
        ["<C-w><C-f>"] = "goto_file_split",
        ["<C-w>gf"] = "goto_file_tab",
        ["<leader>e"] = "focus_files",
        ["<leader>b"] = "toggle_files",
      },
      option_panel = {
        ["<tab>"] = "select_entry",
        ["q"] = "close",
      },
    },
  },
}
