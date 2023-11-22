{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../gtk.nix
    ../wayland-wm
    ../rofi.nix
  ];

  home.packages = lib.attrValues {
    inherit
      (pkgs)
      waybar
      ;
  };
}
