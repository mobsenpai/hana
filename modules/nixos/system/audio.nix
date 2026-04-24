{
  lib,
  pkgs,
  config,
  username,
  ...
}: let
  inherit (lib) mkIf getExe' mkForce singleton getExe;
  inherit (config.modules.core) homeManager;
  inherit (config.modules.system) desktop;
  cfg = config.modules.system.audio;
in
  mkIf cfg.enable
  {
    services.pulseaudio.enable = mkForce false;
    security.rtkit.enable = false;
    users.users.${username}.extraGroups = ["pipewire"];
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
      notify-send = getExe pkgs.libnotify;
      bc = getExe pkgs.bc;

      toggleAudioMute = pkgs.writeShellScript "toggle-audio-mute" ''
        class=$1
        if [[ $class != "source" && $class != "sink" ]]; then
          echo "Invalid device class: '$class'. Must be 'source' or 'sink'." >&2
          exit 1
        fi
        device="@DEFAULT_AUDIO_''${class^^}@"
        inspect_data=$(${wpctl} inspect "$device")

        # @DEFAULT_AUDIO_SOURCE@ can resolve to a sink if no sources exist
        # https://gitlab.freedesktop.org/pipewire/wireplumber/-/issues/509
        if [[ "Audio/''${class^}" != $(echo "$inspect_data" | grep 'media\.class' | cut -d '"' -f 2) ]]; then
          ${notify-send} --transient -u critical -t 2000 \
            -h 'string:x-canonical-private-synchronous:pipewire-volume' 'Toggle Mute' "''${class^} device does not exist"
          exit 0
        fi

        ${wpctl} set-mute "$device" toggle
        status=$(${wpctl} get-volume "$device")
        message=$([[ $status == *MUTED* ]] && echo "Muted" || echo "Unmuted")
        if [[ $class == "SOURCE" ]]; then
          message="Microphone $message"
        fi
        description=$(echo "$inspect_data" | grep 'node\.description' | cut -d '"' -f 2)
        ${notify-send} --transient -u critical -t 2000 \
          -h 'string:x-canonical-private-synchronous:pipewire-volume' "$description" "$message"
      '';

      modifyVolume = pkgs.writeShellScript "modify-volume" ''
        ${wpctl} set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ "$1"
        output=$(${wpctl} get-volume @DEFAULT_AUDIO_SINK@)
        volume=$(echo "$output" | ${getExe pkgs.gawk} '{print $2}')
        percentage="$(echo "$volume * 100" | ${bc})"
        description=$(${wpctl} inspect @DEFAULT_AUDIO_SINK@ | grep 'node\.description' | cut -d '"' -f 2)
        ${notify-send} --urgency=low -t 2000 \
          -h 'string:x-canonical-private-synchronous:pipewire-volume' \
          "$description" "Volume ''${percentage%.*}%"
      '';
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
            "XF86AudioMute".action.spawn = ["${toggleAudioMute}" "sink"];
            "XF86AudioMicMute".action.spawn = ["${toggleAudioMute}" "source"];
            "XF86AudioRaiseVolume".action.spawn = ["${modifyVolume}" "5%+"];
            "XF86AudioLowerVolume".action.spawn = ["${modifyVolume}" "5%-"];
          };
        };

        desktop.hyprland.settings = {
          windowrule = [
            "float, class:^(com\\.saivert\\.pwvucontrol)$"
            "size 60% 60%, class:^(com\\.saivert\\.pwvucontrol)$"
            "center, class:^(com\\.saivert\\.pwvucontrol)$"
          ];

          binde = [
            ", XF86AudioRaiseVolume, exec, ${modifyVolume} 5%+"
            ", XF86AudioLowerVolume, exec, ${modifyVolume} 5%-"
          ];

          bind = [
            ", XF86AudioMute, exec, ${toggleAudioMute} sink"
            ", XF86AudioMicMute, exec, ${toggleAudioMute} source"
          ];
        };
      };

    userPackages = mkIf desktop.enable [pkgs.pwvucontrol];
  }
