{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.modules.core) homeManager;
  inherit (config.modules.system) desktop;
  cfg = config.modules.system.audio;
in
  lib.mkIf cfg.enable
  {
    environment.systemPackages = [pkgs.pavucontrol];
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    hm = mkIf homeManager.enable {
      desktop.hyprland.settings.windowrulev2 = [
        "float, class:^(org.pulseaudio.pavucontrol)$"
        "size 50% 50%, class:^(org.pulseaudio.pavucontrol)$"
        "center, class:^(org.pulseaudio.pavucontrol)$"
      ];
    };

    userPackages = mkIf desktop.enable [pkgs.pavucontrol];
  }
