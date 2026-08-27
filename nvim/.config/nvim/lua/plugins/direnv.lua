-- Load the project's .envrc (direnv) into nvim's environment so that
-- language servers — notably haskell-language-server — run inside the Nix /
-- omnix dev shell. Without this, HLS invokes ghcup's `cabal v2-repl` outside
-- the flake env and fails to resolve Nix-provided packages (e.g. namma-dsl),
-- breaking the cradle for the nammayatri Backend.
return {
  "direnv/direnv.vim",
  lazy = false, -- must run before LSP clients spawn so PATH/env are set
}
