{pkgs ? import <nixpkgs> {}}: {
  firefox-csshacks = pkgs.callPackage ./firefox-csshacks {};
}
