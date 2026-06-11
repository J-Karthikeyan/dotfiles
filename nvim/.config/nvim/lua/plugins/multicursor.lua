return {
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    init = function()
      vim.g.VM_default_mappings = 0
      vim.g.VM_maps = {
        -- Find word under cursor (leader-based to avoid Ctrl-D conflict)
        ["Find Under"] = "<leader>mn",          -- Find next occurrence
        ["Find Subword Under"] = "<leader>mn",  -- Same for subwords
        ["Skip Region"] = "<leader>ms",         -- Skip current, find next
        ["Remove Region"] = "<leader>mr",       -- Remove current cursor
        
        -- Add cursor to adjacent lines (Alt-based to avoid Ctrl conflict)
        ["Add Cursor Down"] = "<M-Down>",       -- Alt+Down
        ["Add Cursor Up"] = "<M-Up>",           -- Alt+Up
        ["Add Cursor At Pos"] = "<leader>m+",   -- Add cursor at click position
        
        -- Visual mode mappings
        ["Visual Add"] = "<leader>ma",          -- Add cursors to visual selection
        ["Visual Find"] = "<leader>mf",         -- Find visual selection
        ["Visual Cursors"] = "<leader>mc",      -- One cursor per line in selection
        
        -- Select all occurrences
        ["Select All"] = "<leader>mA",          -- Select all in buffer
        
        -- Motion while in VM mode
        ["Cursor Operator"] = "<leader>mo",     -- Apply operator to cursors
      }
    end,
    keys = {
      { "<leader>mn", mode = { "n", "x" } },
      { "<leader>ms", mode = { "n", "x" } },
      { "<leader>mr", mode = { "n", "x" } },
      { "<M-Down>", mode = { "n" } },
      { "<M-Up>", mode = { "n" } },
      { "<leader>m+", mode = { "n" } },
      { "<leader>ma", mode = { "x" } },
      { "<leader>mf", mode = { "x" } },
      { "<leader>mc", mode = { "x" } },
      { "<leader>mA", mode = { "n" } },
      { "<leader>mo", mode = { "n" } },
    },
  },
}
