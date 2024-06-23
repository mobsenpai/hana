{lib, ...}: let
  inherit
    (lib)
    utils
    mkOption
    mkAliasOptionModule
    types
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
