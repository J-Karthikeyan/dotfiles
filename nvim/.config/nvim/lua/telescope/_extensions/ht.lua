-- Shim: LazyVim's haskell extra calls load_extension("ht") but telescope_hoogle
-- registers itself under the name "hoogle". Delegate to it here so the lookup
-- succeeds without patching LazyVim or the plugin.
return require("telescope._extensions.hoogle")
