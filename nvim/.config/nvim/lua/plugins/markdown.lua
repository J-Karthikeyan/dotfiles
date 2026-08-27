return {
  -- Replaced markview.nvim (too visually noisy — heading bars, boxes around every
  -- inline code, gutter icons) with render-markdown.nvim, which has calmer,
  -- more readable defaults.
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ft = { "markdown", "markdown.mdx" },
    opts = {
      -- Headings: simple colored text + an icon, no full-width background bars.
      heading = {
        sign = false, -- no gutter sign
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        width = "block", -- background hugs the text, not the whole line
        left_pad = 0,
        right_pad = 2,
      },

      -- Code blocks: full block with a thin border and a language label.
      code = {
        style = "full",
        width = "block",
        border = "thin",
        left_pad = 1,
        right_pad = 2,
      },

      -- Keep the rest quiet.
      dash = { enabled = true },
      bullet = { icons = { "•", "◦", "▪", "▫" } },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)

      -- Near-black background for code blocks / inline code (was a bluish tint).
      -- Re-applied on ColorScheme so it survives theme reloads. Bump toward
      -- #000000 for pure black.
      local code_bg = "#0d0d0d"
      local function set_code_hl()
        vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = code_bg })
        vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { bg = code_bg })
      end
      set_code_hl()
      vim.api.nvim_create_autocmd("ColorScheme", { callback = set_code_hl })

      -- LazyVim enables `spell = true` for markdown, underlining every code term
      -- and name like lint noise. Its own FileType autocmd re-enables spell, and
      -- order isn't guaranteed — so defer with vim.schedule to run last and win.
      -- Flip to `true` if you actually want prose spell-checking.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown" },
        callback = function()
          vim.schedule(function()
            vim.opt_local.spell = false
          end)
        end,
      })
    end,
  },
}
