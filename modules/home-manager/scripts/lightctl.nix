{
  config,
  lib,
  pkgs,
  ...
}: let
  lightctl = pkgs.writeShellScriptBin "lightctl" ''
    case "$1" in
    up)
      ${pkgs.brightnessctl}/bin/brightnessctl -q s +"$2"%
      ;;
    down)
      ${pkgs.brightnessctl}/bin/brightnessctl -q s "$2"%-
      ;;
    esac

    brightness_percentage=$((($(${pkgs.brightnessctl}/bin/brightnessctl g) * 100) / $(${pkgs.brightnessctl}/bin/brightnessctl m)))
    ${pkgs.libnotify}/bin/notify-send --transient \
      -u normal \
      -a "LIGHTCTL" \
      -h string:x-canonical-private-synchronous:lightctl \
      -h int:value:"$brightness_percentage" \
      -i display-brightness-symbolic \
      "LIGHTCTL" "Brightness: $brightness_percentage%"
  '';
in {
  options = {
    myHome.lightctl.enable = lib.mkEnableOption "Enables lightctl";
  };

  config = lib.mkIf config.myHome.lightctl.enable {
    home.packages = [lightctl];
  };
}
