{pkgs ? import <nixpkgs> {}}: {
  nvchad = pkgs.callPackage ./nvchad {};
  gruvbox-icon-theme = pkgs.callPackage ./gruvbox-icon-theme {};
}
