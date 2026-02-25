{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf getExe getExe';
  inherit (config.modules.colorScheme) xcolors;
  inherit (config.modules.desktop.style) font;
  cfg = config.modules.programs.wofi;
in
  mkIf cfg.enable
  {
    programs.wofi = {
      enable = true;
      settings = {
        columns = 1;
        height = "55%";
        hide_scroll = true;
        insensitive = true;
        layer = "top";
        location = "center";
        no_actions = true;
        orientation = "vertical";
        prompt = "";
        width = "25%";
      };

      style =
        /*
        css
        */
        ''
          *{
            all: unset;
            font-family: "${font.family}";
            font-size: 10pt;
            font-weight: normal;
          }

          #window {
            background: ${xcolors.base01};
            border-radius: 8px;
            border: 1px solid ${xcolors.base02};
          }

          #input {
            background: ${xcolors.base01};
            border-bottom: 1px solid ${xcolors.base02};
            color: ${xcolors.base05};
            margin-bottom: 4px;
            padding: 4px;
          }

          #input > image.left {
            margin-right: 4px;
          }

          #input > image.right  {
            margin-left: 4px;
          }

          #outer-box {
            padding: 4px;
          }

          #text {
            color: ${xcolors.base05};
          }

          #entry {
            border-radius: 4px;
            padding: 4px;
          }

          #entry:selected {
            background: ${xcolors.base02};
          }
        '';
    };

    desktop = let
      pkill = getExe' pkgs.procps "pkill";
      wofi = getExe config.programs.wofi.package;
      wofi-emoji = getExe pkgs.wofi-emoji;
      cliphist = getExe pkgs.cliphist;
      wl-copy = getExe' pkgs.wl-clipboard "wl-copy";
    in {
      niri.binds = with config.lib.niri.actions; {
        "Mod+A" = {
          repeat = false;
          action = spawn "sh" "-c" "${pkill} wofi || ${wofi} --show drun";
          hotkey-overlay.title = "Open launcher";
        };

        "Mod+E" = {
          repeat = false;
          action = spawn "sh" "-c" "${pkill} wofi || ${wofi-emoji}";
          hotkey-overlay.title = "Open emoji picker";
        };

        "Mod+V" = {
          repeat = false;
          action = spawn "sh" "-c" "${pkill} wofi || ${cliphist} list | ${wofi} --dmenu | ${cliphist} decode | ${wl-copy}";
          hotkey-overlay.title = "Open clipboard";
        };
      };

      hyprland.settings.binddr = [
        "SUPER, A, Open launcher, exec, ${pkill} wofi || ${wofi} --show drun"
        "SUPER, E, Open emoji picker, exec, ${pkill} wofi || ${wofi-emoji}"
        "SUPER, V, Open clipboard, exec, ${pkill} wofi || ${cliphist} list | ${wofi} --dmenu | ${cliphist} decode | ${wl-copy}"
      ];
    };
  }
