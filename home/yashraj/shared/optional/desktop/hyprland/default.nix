{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../wireless.nix
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
