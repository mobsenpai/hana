{
  lib,
  config,
  osConfig,
  ...
}: let
  inherit (lib) mkIf utils;
  inherit (config.modules.desktop) wallpaper;
  cfg = config.modules.services.hyprpaper;
in
  mkIf cfg.enable
  {
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [
          "${wallpaper}"
        ];
        wallpaper = [
          ",${wallpaper}"
        ];
      };
    };

    systemd.user.services.hyprpaper = {
      Unit = {
        After = lib.mkForce ["graphical-session.target"];
        Requisite = ["graphical-session.target"];
      };

      Service = {
        Slice = "background${utils.sliceSuffix osConfig}.slice";
      };
    };
  }
