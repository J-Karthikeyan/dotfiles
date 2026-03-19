-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- JetBrains IDE New Dark theme colors
local colors = {
  bg = "#191A1C",        -- Main background
  bg_light = "#1E1F22",  -- Slightly lighter
  fg = "#BCBEC4",        -- Main foreground
  magenta = "#C092FA",   -- Accent (keywords)
  blue = "#5594FA",      -- Functions
  green = "#6BCC62",     -- Strings
  yellow = "#E0CE70",    -- Types
  red = "#F27481",       -- Errors
  cyan = "#47CCBD",      -- Special
  gray = "#4E5157",      -- Comments
  selection = "#25324D", -- Selection background
  cursor = "#CED0D6",    -- Cursor
}

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- Set main background
    vim.api.nvim_set_hl(0, "Normal", { bg = colors.bg })

    local groups = {
      "NormalFloat",
      "SignColumn",
      "SnacksNormal",
      "SnacksNormalNC",
      "SnacksWinSeparator",
      "BufferLineBackground",
      "BufferLineFill",
      "BufferLineTab",
      "BufferLineTabSelected",
      "BufferLineTabClose",
      "BufferLineBufferSelected",
      "BufferLineBufferVisible",
      "BufferLineSeparator",
      "BufferLineSeparatorSelected",
      "BufferLineSeparatorVisible",
      "TabLine",
      "TabLineFill",
      "TabLineSel",
      "FloatBorder",
      "FloatTitle",
      "SnacksPicker",
      "SnacksPickerBorder",
      "SnacksPickerTitle",
      "SnacksPickerPreview",
      "SnacksPickerPreviewBorder",
      "SnacksPickerPreviewTitle",
      "SnacksPickerInput",
      "SnacksPickerInputBorder",
      "SnacksPickerList",
      "SnacksPickerListBorder",
      "NoiceCmdlinePopup",
      "NoiceCmdlinePopupBorder",
      "NoiceCmdlinePopupTitle",
    }
    for _, group in ipairs(groups) do
      vim.api.nvim_set_hl(0, group, { bg = "NONE" })
    end

    -- StatusLine - visible separator
    vim.api.nvim_set_hl(0, "StatusLine", { fg = colors.fg, bg = colors.bg })
    vim.api.nvim_set_hl(0, "StatusLineNC", { fg = colors.gray, bg = colors.bg })
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = colors.magenta, bg = "NONE" })

    -- Line numbers
    vim.api.nvim_set_hl(0, "LineNr", { fg = colors.gray, bg = "NONE" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.fg, bg = "NONE" })

    -- Diagnostics
    vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = colors.red, bg = "NONE" })
    vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = colors.yellow, bg = "NONE" })
    vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = colors.blue, bg = "NONE" })
    vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = colors.cyan, bg = "NONE" })

    -- Pmenu
    vim.api.nvim_set_hl(0, "Pmenu", { fg = colors.fg, bg = "NONE" })
    vim.api.nvim_set_hl(0, "PmenuSel", { fg = colors.fg, bg = colors.selection })
    vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "PmenuThumb", { bg = colors.gray })

    -- Completion documentation
    vim.api.nvim_set_hl(0, "CmpDocumentation", { fg = colors.fg, bg = "NONE" })
    vim.api.nvim_set_hl(0, "CmpDocumentationBorder", { fg = colors.gray, bg = "NONE" })

    -- Noice
    vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = colors.blue })

    -- Snacks dashboard
    vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = colors.magenta, bg = "NONE" })
    vim.api.nvim_set_hl(0, "SnacksDashboardFooter", { fg = colors.gray, bg = "NONE" })
    vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = colors.yellow, bg = "NONE" })
    vim.api.nvim_set_hl(0, "SnacksDashboardSpecial", { fg = colors.gray, bg = "NONE" })
    vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = colors.gray, bg = "NONE" })

    -- Indent
    vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#252629", bg = "NONE" })
    vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = colors.gray, bg = "NONE" })

    -- Git signs
    vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = colors.green, bg = "NONE" })
    vim.api.nvim_set_hl(0, "GitSignsChange", { fg = colors.blue, bg = "NONE" })
    vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = colors.red, bg = "NONE" })
    vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = colors.gray, bg = "NONE" })

    -- Markdown headings
    for i = 1, 6 do
      vim.api.nvim_set_hl(0, "RenderMarkdownH" .. i .. "Bg", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "RenderMarkdownH" .. i, { fg = colors.fg, bold = true, bg = "NONE" })
      vim.api.nvim_set_hl(0, "@markup.heading." .. i .. ".markdown", { fg = colors.fg, bold = true, bg = "NONE" })
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.spell = false
  end,
})
