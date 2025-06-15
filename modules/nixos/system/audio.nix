{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf getExe' mkForce;
  inherit (config.modules.core) homeManager;
  inherit (config.modules.system) desktop;
  cfg = config.modules.system.audio;
in
  lib.mkIf cfg.enable
  {
    services.pulseaudio.enable = mkForce false;
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    hm = let
      wpctl = getExe' pkgs.wireplumber "wpctl";
    in
      mkIf homeManager.enable {
        dconf.settings."com/saivert/pwvucontrol".enable-overamplification = true;
        desktop.hyprland.settings = {
          windowrule = [
            "float, class:^(com\\.saivert\\.pwvucontrol)$"
            "size 60% 60%, class:^(com\\.saivert\\.pwvucontrol)$"
            "center, class:^(com\\.saivert\\.pwvucontrol)$"
          ];

          bind = [
            ", XF86AudioMute, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ",XF86AudioMicMute,exec, ${wpctl} set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
            ", XF86AudioRaiseVolume, exec, ${wpctl} set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
            ", XF86AudioLowerVolume, exec, ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ];
        };
      };

    userPackages = mkIf desktop.enable [pkgs.pwvucontrol];
  }
