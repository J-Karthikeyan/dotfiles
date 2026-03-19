-- Extra plugins and configurations preserved from original setup

return {
  -- Flash.nvim for quick navigation
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    },
  },

  -- Bufferline configuration - disabled for cleaner look
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },

  -- Telescope keymaps (preserved from original config)
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader><space>", function() require("telescope.builtin").find_files({ hidden = true }) end, desc = "Find Files (hidden)" },
      { "<leader>ff", function() require("telescope.builtin").find_files({ hidden = true }) end, desc = "Find Files" },
      { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Live Grep" },
      { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Buffers" },
      { "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Help Tags" },
    },
  },

  -- Dropbar for breadcrumbs - disabled for cleaner look
  {
    "Bekaboo/dropbar.nvim",
    enabled = false,
  },

  -- Treesitter with preserved language list
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "python",
        "javascript",
        "typescript",
        "c",
        "cpp",
        "lua",
        "r",
        "tsx",
        "rust",
      },
    },
  },

  -- LSP servers from original config
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
        ts_ls = {},
        clangd = {},
        r_language_server = {},
        tailwindcss = {},
        rust_analyzer = {},
      },
    },
  },

  -- which-key configuration with file explorer keymap
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "File Explorer" },
      },
    },
  },

  -- Disable indent-blankline for cleaner look
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },

  -- Disable mini.indentscope for cleaner look (renamed to nvim-mini)
  {
    "nvim-mini/mini.indentscope",
    enabled = false,
  },

  -- Git conflict resolution
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true,
  },

  -- LazyGit integration
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  -- Better quickfix list for git conflicts and diagnostics
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
  },

  -- Better buffer management
  {
    "chrisgrieser/nvim-early-retirement",
    config = true,
    event = "VeryLazy",
  },
}
