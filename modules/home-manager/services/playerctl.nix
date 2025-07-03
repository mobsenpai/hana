{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: let
  inherit (lib) utils getExe;
in {
  assertions = utils.asserts [
    (osConfig.modules.system.audio.enable)
    "System audio"
  ];

  services.playerctld.enable = true;

  desktop = let
    playerctl = getExe pkgs.playerctl;
  in {
    niri.binds = with config.lib.niri.actions; {
      "XF86AudioPlay".action = spawn playerctl "play-pause";
      "XF86AudioNext".action = spawn playerctl "next";
      "XF86AudioPrev".action = spawn playerctl "previous";
      "XF86AudioStop".action = spawn playerctl "stop";
    };

    hyprland.binds = [
      ", XF86AudioPlay,exec, ${playerctl} play-pause"
      ", XF86AudioNext,exec, ${playerctl} next"
      ", XF86AudioPrev,exec, ${playerctl} previous"
      ", XF86AudioStop,exec, ${playerctl} stop"
    ];
  };
}
