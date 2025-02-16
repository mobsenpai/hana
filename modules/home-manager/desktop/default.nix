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
      url = "https://i.imgur.com/WqurbRF.jpeg";
      sha256 = "1xj630lxy5q789llbpfra7w95f14xz60cllf04c8inl19g3qd5dv";
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
    ];
    services.cliphist.enable = true;
  };
}
