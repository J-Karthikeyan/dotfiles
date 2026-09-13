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
      -- Headings: distinct kanagawa colors per level, an icon, and a subtle
      heading = {
        sign = false, -- no gutter sign
        icons = { "󰲡  ", "󰲣  ", "󰲥  ", "󰲧  ", "󰲩  ", "󰲫  " },
        width = "block", -- background hugs the text, not the whole line
        left_pad = 1,
        right_pad = 3,
        border = false,
      },

      -- Code blocks: full block with a thin border and a language label.
      code = {
        style = "full",
        width = "block",
        border = "thin",
        left_pad = 2,
        right_pad = 3,
        language_pad = 1,
        highlight = "RenderMarkdownCode",
        highlight_inline = "RenderMarkdownCodeInline",

        inline_left = "",
        inline_right = "",
        inline_pad = 1,
      },

      pipe_table = {
        preset = "round",
        cell = "trimmed",
        alignment_indicator = "─",
      },

      quote = { icon = "▐", repeat_linebreak = true },

      bullet = {
        icons = { "●", "○", "◆", "◇" },
        left_pad = 0,
        right_pad = 1,
      },
      checkbox = {
        unchecked = { icon = "󰄱 " },
        checked = { icon = "󰱒 ", scope_highlight = "@markup.strikethrough" },
      },

      dash = { enabled = true, icon = "─", width = "full" },
      link = {
        image = "󰥶 ",
        hyperlink = "󰌷 ",
        wiki = { icon = "󰖟 " },
      },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)

      -- Kanagawa "dragon" palette — pull real values so highlights track the
      -- theme instead of being hand-picked hexes.
      local ok, palette = pcall(require, "kanagawa.colors")
      local c = ok and palette.setup({ theme = "dragon" }).palette or {}

      -- Fallbacks in case the palette module isn't available.
      c.dragonRed = c.dragonRed or "#c4746e"
      c.dragonOrange = c.dragonOrange or "#b6927b"
      c.dragonYellow = c.dragonYellow or "#c4b28a"
      c.dragonGreen = c.dragonGreen or "#87a987"
      c.dragonBlue = c.dragonBlue or "#8ba4b0"
      c.dragonViolet = c.dragonViolet or "#8992a7"
      c.dragonPink = c.dragonPink or "#a292a3"
      c.dragonWhite = c.dragonWhite or "#c5c9c5"
      c.dragonGray = c.dragonGray or "#a6a69c"

      local hl = vim.api.nvim_set_hl

      local function apply()
        local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
        local solid = normal.bg ~= nil

        hl(0, "RenderMarkdownCode", { bg = "#2a2825" })
        hl(0, "RenderMarkdownCodeInline", { fg = c.dragonGreen, bg = "#32302c" })
        hl(0, "RenderMarkdownH1", { fg = c.dragonRed, bold = true })
        hl(0, "RenderMarkdownH2", { fg = c.dragonOrange, bold = true })
        hl(0, "RenderMarkdownH3", { fg = c.dragonYellow, bold = true })
        hl(0, "RenderMarkdownH4", { fg = c.dragonGreen, bold = true })
        hl(0, "RenderMarkdownH5", { fg = c.dragonBlue, bold = true })
        hl(0, "RenderMarkdownH6", { fg = c.dragonViolet, bold = true })

        local function head_bg(group, fg, tint)
          hl(0, group, { fg = fg, bg = solid and tint or "NONE", bold = true })
        end
        head_bg("RenderMarkdownH1Bg", c.dragonRed, "#2a1c1b")
        head_bg("RenderMarkdownH2Bg", c.dragonOrange, "#241d18")
        head_bg("RenderMarkdownH3Bg", c.dragonYellow, "#25211a")
        head_bg("RenderMarkdownH4Bg", c.dragonGreen, "#1c231c")
        head_bg("RenderMarkdownH5Bg", c.dragonBlue, "#1b2226")
        head_bg("RenderMarkdownH6Bg", c.dragonViolet, "#1e2029")

        -- Tables: readable borders + header, transparent cell fill.
        hl(0, "RenderMarkdownTableHead", { fg = c.dragonBlue, bold = true })
        hl(0, "RenderMarkdownTableRow", { fg = c.dragonWhite })
        hl(0, "RenderMarkdownTableFill", { fg = c.dragonGray })

        -- Bullets, quotes, dashes, links — calm but visible.
        hl(0, "RenderMarkdownBullet", { fg = c.dragonBlue })
        hl(0, "RenderMarkdownQuote", { fg = c.dragonGreen })
        hl(0, "RenderMarkdownDash", { fg = c.dragonGray })
        hl(0, "RenderMarkdownLink", { fg = c.dragonAqua or c.dragonBlue, underline = true })
      end

      apply()
      vim.api.nvim_create_autocmd("ColorScheme", { callback = apply })

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
