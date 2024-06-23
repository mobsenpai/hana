{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.modules.system.audio;
in {
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [pkgs.pavucontrol];
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    sound = {
      enable = true;
      mediaKeys.enable = true;
    };
  };
}
