return {
  "snacks.nvim",
  opts = function(_, opts)
    -- Get current directory name
    local cwd = vim.fn.getcwd()
    local dir_name = vim.fn.fnamemodify(cwd, ":t")

    -- Create a simple header with just the directory name
    opts.dashboard = opts.dashboard or {}
    opts.dashboard.preset = opts.dashboard.preset or {}
    opts.dashboard.preset.header = "\n  " .. dir_name .. "\n"

    opts.dashboard.sections = {
      { section = "header" },
      { icon = "", key = "e", desc = "New file", action = ":ene" },
      { icon = "", key = "f", desc = "Find file", action = function() Snacks.picker.files() end },
      { icon = "", key = "r", desc = "Recent files", action = function() Snacks.picker.recent() end },
      { icon = "", key = "g", desc = "Find text", action = function() Snacks.picker.grep() end },
      { icon = "", key = "c", desc = "Config", action = ":cd ~/.config/nvim | e lua/config/options.lua" },
      { icon = "", key = "l", desc = "Lazy", action = ":Lazy" },
      { icon = "", key = "q", desc = "Quit", action = ":qa" },
      { section = "startup" },
    }

    return opts
  end,
}
