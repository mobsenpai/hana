{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: let
  inherit (lib) utils mkIf mkOption getExe types;
  cfg = osConfig.modules.system.desktop;
in {
  imports = utils.scanPaths ./.;

  options.modules.desktop = {
    windowManager = mkOption {
      type = types.nullOr (types.enum ["Hyprland"]);
      default = null;
      description = "Window manager to use";
    };

    terminal = {
      exePath = mkOption {
        type = types.str;
        default = getExe config.programs.alacritty.package;
      };

      class = mkOption {
        type = types.str;
        default = "Alacritty";
        description = "Window class of the terminal";
      };

      description = "Information about the default terminal";
    };

    wallpaper = let
      url = "https://i.imgur.com/YU169OL.png";
      sha256 = "073rw08hvb3ls8x4j5zsm3bcq97fni3hyzbzrv4akah2sxzibqhr";
      ext = lib.last (lib.splitString "." url);
    in {
      default = mkOption {
        type = lib.types.path;
        default = builtins.fetchurl {
          name = "wallpaper-${sha256}.${ext}";
          inherit url sha256;
        };
        description = ''
          The default wallpaper to use.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      wl-clipboard
      gnome.nautilus
    ];
    services.cliphist.enable = true;
  };
}
