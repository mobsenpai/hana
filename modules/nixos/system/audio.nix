{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf getExe' mkForce singleton;
  inherit (config.modules.core) homeManager;
  inherit (config.modules.system) desktop;
  cfg = config.modules.system.audio;
in
  mkIf cfg.enable
  {
    services.pulseaudio.enable = mkForce false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
      extraConfig.pipewire."99-input-denoising.conf" = mkIf cfg.inputNoiseSuppression {
        "context.modules" = singleton {
          name = "libpipewire-module-filter-chain";
          args = {
            "node.description" = "Noise Canceling source";
            "media.name" = "Noise Canceling source";
            "filter.graph" = {
              nodes = singleton {
                type = "ladspa";
                name = "rnnoise";
                plugin = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
                label = "noise_suppressor_mono";
                control = {
                  "VAD Threshold (%)" = 50.0;
                  "VAD Grace Period (ms)" = 200;
                  "Retroactive VAD Grace (ms)" = 0;
                };
              };
            };

            "capture.props" = {
              "node.name" = "capture.rnnoise_source";
              "node.passive" = true;
              "audio.rate" = 48000;
            };

            "playback.props" = {
              "node.name" = "rnnoise_source";
              "media.class" = "Audio/Source";
              "audio.rate" = 48000;
            };
          };
        };
      };
    };

    hm = let
      wpctl = getExe' pkgs.wireplumber "wpctl";
    in
      mkIf homeManager.enable {
        dconf.settings."com/saivert/pwvucontrol".enable-overamplification = true;
        desktop.niri.settings = {
          window-rules = [
            {
              matches = [{app-id = "com\\.saivert\\.pwvucontrol";}];
              open-floating = true;
              default-column-width = {proportion = 0.6;};
              default-window-height = {proportion = 0.6;};
            }
          ];

          binds = {
            "XF86AudioMute".action.spawn = [wpctl "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
            "XF86AudioMicMute".action.spawn = [wpctl "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"];
            "XF86AudioRaiseVolume".action.spawn = [wpctl "set-volume" "-l" "1.0" "@DEFAULT_AUDIO_SINK@" "5%+"];
            "XF86AudioLowerVolume".action.spawn = [wpctl "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"];
          };
        };

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
