-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Yank current file path to system clipboard. Shows a brief confirmation so
-- you know what landed in the clipboard.
local function yank_path(modifier, label)
  local path = vim.fn.expand("%:" .. modifier)
  vim.fn.setreg("+", path)
  vim.notify(label .. ": " .. path, vim.log.levels.INFO)
end

vim.keymap.set("n", "<leader>yp", function()
  yank_path("p", "abs")
end, { desc = "Yank absolute path" })
vim.keymap.set("n", "<leader>yr", function()
  yank_path(".", "rel")
end, { desc = "Yank relative path" })
vim.keymap.set("n", "<leader>yn", function()
  yank_path("t", "name")
end, { desc = "Yank file name" })
vim.keymap.set("n", "<leader>yd", function()
  yank_path("p:h", "dir")
end, { desc = "Yank parent directory" })

vim.keymap.set("n", "<leader>uw", function()
  vim.wo.wrap = not vim.wo.wrap
  vim.notify("wrap " .. (vim.wo.wrap and "ON (prose)" or "OFF (wide tables intact)"), vim.log.levels.INFO)
end, { desc = "Toggle wrap (wide tables)" })

vim.keymap.set("n", "<leader>um", function()
  local ok, state = pcall(require, "render-markdown.state")
  if not ok or not state.config then
    return vim.notify("render-markdown not loaded (open a markdown file first)", vim.log.levels.WARN)
  end
  -- We're in edit mode while anti-conceal is still enabled.
  local to_read = state.config.anti_conceal.enabled ~= false
  state.config.anti_conceal.enabled = not to_read -- persists for new md buffers
  for _, cfg in pairs(state.cache) do -- already-open md buffers
    cfg.anti_conceal.enabled = not to_read
  end
  vim.wo.concealcursor = to_read and "nvic" or ""
  require("render-markdown.api").set_buf(true) -- force re-render
  vim.notify(
    "markdown: " .. (to_read and "READ mode (full render)" or "EDIT mode (raw on cursor line)"),
    vim.log.levels.INFO
  )
end, { desc = "Toggle markdown read mode (full render)" })

local solid_bg = false -- start GLASSY, matching the colorscheme.lua default
local function set_display_mode(solid)
  require("kanagawa").setup({
    theme = "dragon",
    transparent = not solid,
    colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
  })
  vim.cmd.colorscheme("kanagawa-dragon") -- reload; re-fires ColorScheme highlights
  if vim.fn.executable("kitty") == 1 then
    vim.system({ "kitty", "@", "set-background-opacity", solid and "1.0" or "0.85" }, { text = true }, function(res)
      if res.code ~= 0 then
        vim.schedule(function()
          vim.notify(
            "kitty opacity failed (allow_remote_control on? kitty restarted?): " .. (res.stderr or ""),
            vim.log.levels.WARN
          )
        end)
      end
    end)
  end
end
vim.keymap.set("n", "<leader>ut", function()
  solid_bg = not solid_bg
  set_display_mode(solid_bg)
  vim.notify(
    "display: " .. (solid_bg and "SOLID (opaque · kanagawa bg)" or "GLASSY (transparent · wallpaper)"),
    vim.log.levels.INFO
  )
end, { desc = "Toggle solid/glassy display" })
