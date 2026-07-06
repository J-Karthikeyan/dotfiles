-- Solid bufferline strip on a transparent nvim background.
-- The whole tab area uses `bar_bg`, active tab is lifted with `active_bg`.
-- Single bg for the whole strip — no "lifted" active tab, so no visible
-- boundary rectangle between tabs. Active tab is differentiated by bold text
-- and brighter fg only.
local bar_bg = "#1d1c19" -- kanagawa base
local active_bg = bar_bg -- match — keeps everything flat
local active_fg = "#C8C093"
local inactive_fg = "#625e5a"
local modified_fg = "#c4b28a"

-- LazyVim uses mini.icons (not nvim-web-devicons). Bufferline renders icons
-- with the MiniIcons<Color> highlight groups, which have bg=NONE — that's why
-- transparent boxes show through behind icons. Patch them to use bar_bg so
-- they blend into the strip. Active tabs will show a faint bar_bg square
-- behind icons, which is acceptable; a perfect fix would need per-state hl
-- groups via bufferline's get_element_icon hook.
local function patch_bgs()
  -- Make all mini.icons highlights sit on the bar bg.
  for name, _ in pairs(vim.api.nvim_get_hl(0, {})) do
    if name:match("^MiniIcons") then
      local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
      vim.api.nvim_set_hl(0, name, { fg = hl.fg, bg = bar_bg })
    end
  end
  -- FORCE bg on every BufferLine* group regardless of what's there. Selected
  -- variants get active_bg, everything else gets bar_bg. Also strip italic
  -- because kanagawa's bufferline integration sets it on selected buffers.
  for name, _ in pairs(vim.api.nvim_get_hl(0, {})) do
    if name:match("^BufferLine") then
      local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
      local target_bg = name:match("Selected$") and active_bg or bar_bg
      vim.api.nvim_set_hl(0, name, vim.tbl_extend("force", hl, {
        bg = target_bg,
        italic = false,
      }))
    end
  end
  -- Re-assert the buffer-name highlights so the colorscheme can't paint over
  -- our chosen colors. These run AFTER the loop above so they win.
  vim.api.nvim_set_hl(0, "BufferLineBufferSelected",
    { bg = active_bg, fg = active_fg, bold = true, italic = false })
  vim.api.nvim_set_hl(0, "BufferLineBackground",
    { bg = bar_bg, fg = inactive_fg, italic = false })
  vim.api.nvim_set_hl(0, "BufferLineBufferVisible",
    { bg = bar_bg, fg = inactive_fg, italic = false })
end

vim.api.nvim_create_autocmd(
  { "ColorScheme", "VimEnter", "BufEnter", "BufModifiedSet", "TextChanged", "TextChangedI" },
  {
    callback = function()
      vim.schedule(patch_bgs)
    end,
  }
)

return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        mode = "buffers",
        separator_style = { "", "" }, -- no separators, let the bg do the talking
        always_show_bufferline = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_buffer_icons = true,
        color_icons = true,
        indicator = { style = "none" },
        max_name_length = 30,
        tab_size = 0, -- shrink-wrap tabs to their content
        padding = 1,
        modified_icon = "●",
        name_formatter = function(buf)
          local max_len = 18
          local name = buf.name
          if #name > max_len then
            name = string.sub(name, 1, max_len) .. "…"
          end
          return " " .. name .. " "
        end,
        offsets = {
          { filetype = "neo-tree", text = "Explorer", highlight = "Directory", text_align = "left" },
          { filetype = "oil", text = "Files", highlight = "Directory", text_align = "left" },
        },
      },
      highlights = {
        -- Bar background (empty space in the tab strip)
        fill = { bg = bar_bg },

        -- Inactive buffers
        background = { bg = bar_bg, fg = inactive_fg },
        buffer_visible = { bg = bar_bg, fg = inactive_fg },
        duplicate = { bg = bar_bg, fg = inactive_fg, italic = false },
        duplicate_visible = { bg = bar_bg, fg = inactive_fg, italic = false },

        -- Active buffer (lifted card)
        buffer_selected = { bg = active_bg, fg = active_fg, bold = true, italic = false },
        duplicate_selected = { bg = active_bg, fg = active_fg, italic = false },

        -- Modified indicator
        modified = { bg = bar_bg, fg = modified_fg },
        modified_visible = { bg = bar_bg, fg = modified_fg },
        modified_selected = { bg = active_bg, fg = modified_fg },

        -- Separators — make them blend (same fg+bg as the bar)
        separator = { bg = bar_bg, fg = bar_bg },
        separator_visible = { bg = bar_bg, fg = bar_bg },
        separator_selected = { bg = bar_bg, fg = bar_bg },

        -- Tab close icons (we hide these but keep colors consistent)
        close_button = { bg = bar_bg, fg = inactive_fg },
        close_button_visible = { bg = bar_bg, fg = inactive_fg },
        close_button_selected = { bg = active_bg, fg = active_fg },

        -- Devicons should sit on the right background
        numbers = { bg = bar_bg, fg = inactive_fg },
        numbers_visible = { bg = bar_bg, fg = inactive_fg },
        numbers_selected = { bg = active_bg, fg = active_fg, bold = true },

        -- Tab/group labels (when using tabs grouping)
        tab = { bg = bar_bg, fg = inactive_fg },
        tab_selected = { bg = active_bg, fg = active_fg },
        tab_close = { bg = bar_bg, fg = inactive_fg },

        -- Indicator (we disabled the icon, but the highlight still needs a bg)
        indicator_selected = { bg = active_bg, fg = active_bg },
        indicator_visible = { bg = bar_bg, fg = bar_bg },

        -- Pick mode (when you use BufferLinePick)
        pick = { bg = bar_bg, fg = "#e46876", bold = true },
        pick_visible = { bg = bar_bg, fg = "#e46876", bold = true },
        pick_selected = { bg = active_bg, fg = "#e46876", bold = true },
      },
    },
  },
}
