{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: let
  inherit (lib) mkIf utils mkOption types;
  cfg = config.modules.desktop;
  osDesktop = osConfig.modules.system.desktop;
in {
  imports = utils.scanPaths ./.;

  options.modules.desktop = {
    terminal = mkOption {
      type = types.nullOr (types.enum ["Alacritty"]);
      default = null;
      description = ''
        XDG desktop ID of the default terminal to use with xdg-terminal-exec.
        The terminal should have its desktop entry modified to comply with the
        xdg-terminal-exec spec.
      '';
    };

    windowManager = mkOption {
      type = types.nullOr (types.enum ["Hyprland" "Niri"]);
      default = null;
      description = "Window manager to use";
    };

    style = {
      font = {
        family = mkOption {
          type = types.str;
          default = "FiraMono Nerd Font";
          description = "Font family name";
        };

        package = mkOption {
          type = types.package;
          default = pkgs.nerd-fonts.fira-mono;
        };
      };
    };
  };

  config = mkIf osDesktop.enable {
    assertions = utils.asserts [
      (osDesktop.enable)
      "You cannot enable home-manager desktop if NixOS desktop is not enabled"
      (cfg.terminal != null)
      "A default desktop terminal must be set"
      (cfg.windowManager != null -> osDesktop.desktopEnvironment == null)
      "You cannot use a desktop environemnt with a window manager"
    ];

    home.packages = with pkgs; [
      xdg-terminal-exec
      wl-clipboard
    ];

    xdg.configFile."xdg-terminals.list".text = ''
      ${cfg.terminal}.desktop
    '';

    dconf.settings = {
      "org/gtk/settings/file-chooser".show-hidden = true;
      "org/gtk/gtk4/settings/file-chooser".show-hidden = true;
    };
  };
}
