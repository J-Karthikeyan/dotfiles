-- Kanagawa Dragon color palette for gitsigns highlights
local colors = {
  green = "#87a987",
  blue = "#7E9CD8",
  yellow = "#c4b28a",
  red = "#c4746e",
  teal = "#8ea4a2",
  gray = "#625e5a",
  violet = "#957FB8",
  bg = "#181616",
}

-- Apply Kanagawa Dragon colors to GitSigns highlight groups
local function set_gitsigns_highlights()
  vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = colors.green })
  vim.api.nvim_set_hl(0, "GitSignsChange", { fg = colors.blue })
  vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = colors.red })
  vim.api.nvim_set_hl(0, "GitSignsChangedelete", { fg = colors.yellow })
  vim.api.nvim_set_hl(0, "GitSignsTopdelete", { fg = colors.red })
  vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = colors.teal })
  vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = colors.gray, italic = true })

  -- Highlight overrides for staged signs
  vim.api.nvim_set_hl(0, "GitSignsAddStaged", { fg = colors.green })
  vim.api.nvim_set_hl(0, "GitSignsChangeStaged", { fg = colors.blue })
  vim.api.nvim_set_hl(0, "GitSignsDeleteStaged", { fg = colors.red })
  vim.api.nvim_set_hl(0, "GitSignsChangedeleteStaged", { fg = colors.yellow })
  vim.api.nvim_set_hl(0, "GitSignsTopdeleteStaged", { fg = colors.red })
  vim.api.nvim_set_hl(0, "GitSignsUntrackedStaged", { fg = colors.teal })
end

-- Ensure highlights are set immediately and re-applied on colorscheme change
set_gitsigns_highlights()
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
  callback = set_gitsigns_highlights,
})

return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      -- Gutter sign characters using simple line characters
      signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "┆" },
        untracked    = { text = "┆" },
      },
      signs_staged = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "┆" },
        untracked    = { text = "┆" },
      },

      -- Performance and visual settings
      sign_priority = 6,
      max_file_length = 10000,
      word_diff = false,

      -- Current line blame settings
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text_pos = "eol",
        delay = 300,
      },
      current_line_blame_formatter = "  <author>, <author_time:%R> — <summary>",

      -- Preview window formatting
      preview_config = {
        border = "rounded",
      },

      -- Buffer-local keymaps attached when gitsigns activates on a buffer
      on_attach = function(bufnr)
        local gs = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation with repeat / schedule wrap support and diff mode check
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            vim.schedule(function()
              gs.nav_hunk("next")
            end)
          end
        end, { desc = "Next Git Hunk" })

        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            vim.schedule(function()
              gs.nav_hunk("prev")
            end)
          end
        end, { desc = "Prev Git Hunk" })

        -- Actions: Hunk operations
        map("n", "<leader>gp", gs.preview_hunk_inline, { desc = "Preview Hunk Inline" })
        map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage Hunk" })
        map("v", "<leader>gs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Stage Hunk" })
        map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
        map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset Hunk" })
        map("v", "<leader>gr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Reset Hunk" })

        -- Actions: Buffer operations
        map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage Buffer" })
        map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset Buffer" })

        -- Blame keymaps
        map("n", "<leader>gb", function()
          gs.blame_line({ full = true })
        end, { desc = "Blame Current Line (Popup)" })
        map("n", "<leader>gB", gs.toggle_current_line_blame, { desc = "Toggle Full File Line Blame" })

        -- Diff keymaps
        map("n", "<leader>gd", gs.diffthis, { desc = "Diff Against Index" })
        map("n", "<leader>gD", function()
          gs.diffthis("~1")
        end, { desc = "Diff Against HEAD~1" })

        -- Toggles
        map("n", "<leader>gtd", gs.toggle_deleted, { desc = "Toggle Deleted Lines" })
        map("n", "<leader>gtw", gs.toggle_word_diff, { desc = "Toggle Word Diff" })

        -- Text object: Select hunk (operator-pending and visual modes)
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Git Hunk Text Object" })
      end,
    },
  },
}
