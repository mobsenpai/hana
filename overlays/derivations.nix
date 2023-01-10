final: prev: {
  firefox-csshacks = prev.callPackage ../derivations/firefox-csshacks.nix {src = prev.firefox-csshacks-src;};
  arkenfox = prev.callPackage ../derivations/arkenfox.nix {src = prev.arkenfox-src;};
}
