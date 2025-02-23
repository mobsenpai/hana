{lib, ...}: let
  inherit
    (lib)
    utils
    mkAliasOptionModule
    ;
in {
  imports =
    utils.scanPaths ./.
    ++ [
      (mkAliasOptionModule
        ["desktop" "hyprland" "binds"]
        ["wayland" "windowManager" "hyprland" "settings" "bind"])

      (mkAliasOptionModule
        ["desktop" "hyprland" "settings"]
        ["wayland" "windowManager" "hyprland" "settings"])
    ];
}
