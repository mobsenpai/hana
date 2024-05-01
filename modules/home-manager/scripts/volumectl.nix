{
  config,
  lib,
  pkgs,
  ...
}: let
  # Volume control utility
  volumectl = pkgs.writeShellScriptBin "volumectl" ''
    #!/usr/bin/env bash

    case "$1" in
    up)
      ${pkgs.pamixer}/bin/pamixer -i "$2"
      ;;
    down)
      ${pkgs.pamixer}/bin/pamixer -d "$2"
      ;;
    toggle-mute)
      ${pkgs.pamixer}/bin/pamixer -t
      ;;
    esac

    volume_percentage="$(${pkgs.pamixer}/bin/pamixer --get-volume)"
    isMuted="$(${pkgs.pamixer}/bin/pamixer --get-mute)"

    if [ "$isMuted" = "true" ]; then
      ${pkgs.libnotify}/bin/notify-send --transient \
        -u normal \
        -a "VOLUMECTL" \
        -i audio-volume-muted-symbolic \
        "VOLUMECTL" "Volume Muted"
    else
      ${pkgs.libnotify}/bin/notify-send --transient \
        -u normal \
        -a "VOLUMECTL" \
        -h string:x-canonical-private-synchronous:volumectl \
        -h int:value:"$volume_percentage" \
        -i audio-volume-high-symbolic \
        "VOLUMECTL" "Volume: $volume_percentage%"

      ${pkgs.libcanberra-gtk3}/bin/canberra-gtk-play -i audio-volume-change -d "volumectl"
    fi
  '';
in {
  options = {
    myHome.volumectl.enable = lib.mkEnableOption "Enables volumectl";
  };

  config = lib.mkIf config.myHome.volumectl.enable {
    home.packages = [volumectl];
  };
}
