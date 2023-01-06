final: prev: {
  firefox-csshacks = prev.callPackage ../derivations/firefox-csshacks.nix {src = prev.firefox-csshacks-src;};
}
