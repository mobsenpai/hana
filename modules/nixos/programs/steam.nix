{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.modules.core) homeManager;
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
      desktop.niri.settings = {
        window-rules = [
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
      };

      desktop.hyprland.settings = {
        windowrule = [
          "float, class:^(com\\.saivert\\.pwvucontrol)$"
          "size 60% 60%, class:^(com\\.saivert\\.pwvucontrol)$"
          "center, class:^(com\\.saivert\\.pwvucontrol)$"
        ];
      };
    };
  }
