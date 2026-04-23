-- haskell-tools.nvim override
-- LazyVim's lang.haskell extra defaults to Mason's HLS binary, which is
-- compiled for a fixed GHC version (currently 9.10.3). Projects using Nix
-- flakes (like haskell-intro) pin their own GHC (9.2.8) and ship a matching
-- HLS via direnv. We tell haskell-tools to use PATH so direnv.vim's injected
-- flake PATH wins over Mason's hardcoded binary.
return {
  {
    "mrcjkb/haskell-tools.nvim",
    version = "^3",
    -- haskell-tools has no setup() function — configure via vim.g.haskell_tools
    -- global set BEFORE the plugin loads. Using opts= would trigger setup() → crash.
    init = function()
      -- vim.g doesn't support nested mutation — assign the whole table at once.
      -- Use haskell-language-server-wrapper from $PATH so direnv.vim's
      -- flake-injected PATH wins over Mason's wrong-GHC binary.
      vim.g.haskell_tools = {
        hls = {
          cmd = function(_)
            -- Mason's bin is first in PATH but its HLS targets the wrong GHC.
            -- Walk PATH manually, skip Mason's bin, use first HLS found (flake's).
            local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
            for entry in vim.env.PATH:gmatch("[^:]+") do
              if entry ~= mason_bin then
                local candidate = entry .. "/haskell-language-server-wrapper"
                if vim.fn.executable(candidate) == 1 then
                  return { candidate, "--lsp" }
                end
              end
            end
            return { "haskell-language-server-wrapper", "--lsp" }
          end,
        },
      }
    end,
  },

  -- telescope_hoogle registers as "hoogle" but LazyVim calls load_extension("ht").
  -- The shim at lua/telescope/_extensions/ht.lua delegates "ht" → "hoogle"
  -- so no further override is needed here.
}
