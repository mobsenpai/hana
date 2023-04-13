{pkgs ? import <nixpkgs> {}}: {
  firefox-csshacks = pkgs.callPackage ./firefox-csshacks {};
  nvchad = pkgs.callPackage ./nvchad {};
}
