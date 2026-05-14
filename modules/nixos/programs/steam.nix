{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.modules.core) homeManager;
  inherit (config.modules.system) device;
  cfg = config.modules.programs.gaming;
in
  mkIf cfg.enable
  {
    programs.steam = {
      enable = true;
      protontricks.enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
    };

    hm = mkIf homeManager.enable {
      desktop.niri.settings.window-rules = [
        {
          matches = [
            {
              app-id = "steam";
              title = "Friends List";
            }
          ];
          open-floating = true;
          default-column-width = {proportion = 0.6;};
          default-window-height = {proportion = 0.6;};
        }
      ];

      desktop.hyprland.settings.windowrule = [
        "float, class:^(steam)$, title:^(Friends List)$"
        "size 60% 60%, class:^(steam)$, title:^(Friends List)$"
        "center, class:^(steam)$, title:^(Friends List)$"
      ];

      # Fix slow steam client downloads https://redd.it/16e1l4h
      # Speed up shader processing by using more than a single thread
      home.file.".steam/steam/steam_dev.cfg".text = ''
        @nClientDownloadEnableHTTP2PlatformLinux 0
        unShaderBackgroundProcessingThreads ${toString device.cpu.threads}
      '';
    };
  }
