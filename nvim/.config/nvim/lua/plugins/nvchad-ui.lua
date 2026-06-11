vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"

local jb = {
  active_fg = "#BCBEC4",
  inactive_fg = "#6F737A",
  modified = "#6BCC62",
  close = "#F27481",
  accent = "#C092FA",
}

local tb_overrides = {
  TabLine = { bg = "NONE", fg = "NONE" },
  TabLineFill = { bg = "NONE", fg = "NONE" },
  TabLineSel = { bg = "NONE", fg = "NONE" },
  Tabline = { bg = "NONE" },
  TbFill = { bg = "NONE" },
  TbBufOn = { fg = jb.active_fg, bg = "NONE", bold = true },
  TbBufOff = { fg = jb.inactive_fg, bg = "NONE" },
  TbBufOnModified = { fg = jb.modified, bg = "NONE", bold = true },
  TbBufOffModified = { fg = jb.modified, bg = "NONE" },
  TbBufOnClose = { fg = jb.close, bg = "NONE" },
  TbBufOffClose = { fg = jb.inactive_fg, bg = "NONE" },
  TbThemeToggleBtn = { fg = jb.accent, bg = "NONE", bold = true },
  TbCloseAllBufsBtn = { fg = jb.close, bg = "NONE", bold = true },
  TbTabNewBtn = { fg = jb.accent, bg = "NONE" },
  TbTabOn = { fg = jb.accent, bg = "NONE", bold = true },
  TbTabOff = { fg = jb.inactive_fg, bg = "NONE" },
  TbTabCloseBtn = { fg = jb.close, bg = "NONE" },
  TBTabTitle = { fg = jb.active_fg, bg = "NONE", bold = true },
}

local function apply_tb_overrides()
  for group, val in pairs(tb_overrides) do
    local parts = { "guibg=NONE" }
    if val.fg then table.insert(parts, "guifg=" .. val.fg) end
    if val.bold then table.insert(parts, "gui=bold") else table.insert(parts, "gui=NONE") end
    vim.cmd("hi! " .. group .. " " .. table.concat(parts, " "))
  end
end

_G._apply_tb_overrides = apply_tb_overrides

return {
  { "nvim-lualine/lualine.nvim", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },

  {
    "nvchad/base46",
    lazy = false,
    priority = 1000,
    build = function()
      require("base46").load_all_highlights()
    end,
    config = function()
      local function load_cache()
        for _, name in ipairs({ "statusline", "tbline", "devicons" }) do
          local path = vim.g.base46_cache .. name
          if vim.uv.fs_stat(path) then
            dofile(path)
          end
        end
        apply_tb_overrides()
      end
      load_cache()
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.schedule(load_cache)
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "NvThemeReload",
        callback = apply_tb_overrides,
      })
    end,
  },

  {
    "nvchad/ui",
    lazy = false,
    dependencies = { "nvzone/volt", "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.api.nvim_create_autocmd({ "BufAdd", "BufEnter" }, {
        callback = function()
          if vim.t.bufs then
            vim.t.bufs = vim.tbl_filter(vim.api.nvim_buf_is_valid, vim.t.bufs)
          end
        end,
      })
      require("nvchad")
      apply_tb_overrides()
    end,
  },
}
