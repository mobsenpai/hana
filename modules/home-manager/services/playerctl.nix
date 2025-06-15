{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib) utils getExe;
  playerctl = getExe pkgs.playerctl;
in {
  assertions = utils.asserts [
    (osConfig.modules.system.audio.enable)
    "System audio"
  ];

  services.playerctld.enable = true;

  desktop.hyprland.binds = [
    ", XF86AudioNext,exec, ${playerctl} next"
    ", XF86AudioPrev,exec, ${playerctl} previous"
    ", XF86AudioPlay,exec, ${playerctl} play-pause"
    ", XF86AudioStop,exec, ${playerctl} stop"
  ];
}
