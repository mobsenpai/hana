{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.modules.programs.media;
in
  lib.mkIf cfg.enable
  {
    home.packages = with pkgs; [
      imv
      mpv
    ];

    xdg.mimeApps.defaultApplications = {
      "audio/*" = "mpv.desktop";
      "image/*" = "imv.desktop";
      "video/*" = "mpv.desktop";
    };
  }
