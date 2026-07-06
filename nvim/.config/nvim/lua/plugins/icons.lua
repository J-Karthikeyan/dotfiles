-- Override mini.icons glyphs for filetypes whose default icon has a
-- visible "dark box" baked into the font design. We use Lua's \u{HEX}
-- escape so the codepoints survive any editor/transport stripping.
--
-- Glyph reference (all from Nerd Fonts):
--   \u{e235}  nf-dev-python      -- clean snake, no box
--   \u{f0868} nf-md-docker       -- material docker whale
--   \u{f0320} nf-md-language_python
return {
  {
    "nvim-mini/mini.icons",
    opts = {
      file = {
        ["Dockerfile"] = { glyph = "\u{f0868}", hl = "MiniIconsBlue" },
        [".dockerignore"] = { glyph = "\u{f0868}", hl = "MiniIconsGrey" },
      },
      extension = {
        py = { glyph = "\u{e235}", hl = "MiniIconsYellow" },
        pyi = { glyph = "\u{e235}", hl = "MiniIconsYellow" },
        pyc = { glyph = "\u{e235}", hl = "MiniIconsGrey" },
      },
      filetype = {
        python = { glyph = "\u{e235}", hl = "MiniIconsYellow" },
        dockerfile = { glyph = "\u{f0868}", hl = "MiniIconsBlue" },
      },
    },
  },
}
