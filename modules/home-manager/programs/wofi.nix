{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf getExe getExe';
  inherit (config.modules.colorScheme) xcolors;
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
            font-family: "FiraMono Nerd Font";
            font-size: 10pt;
            font-weight: normal;
          }

          #window {
            background: ${xcolors.bg1};
            border-radius: 8px;
            border: 1px solid ${xcolors.bg2};
          }

          #input {
            background: ${xcolors.bg1};
            border-bottom: 1px solid ${xcolors.bg2};
            color: ${xcolors.fg1};
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
            color: ${xcolors.fg1};
          }

          #entry {
            border-radius: 4px;
            padding: 4px;
          }

          #entry:selected {
            background: ${xcolors.bg2};
          }
        '';
    };

    desktop.hyprland.settings.bindr = let
      pkill = getExe' pkgs.procps "pkill";
      wofi = getExe config.programs.wofi.package;
      wofi-emoji = getExe pkgs.wofi-emoji;
      cliphist = getExe pkgs.cliphist;
      wl-copy = getExe' pkgs.wl-clipboard "wl-copy";
    in [
      "SUPER, A, exec, ${pkill} wofi || ${wofi} --show drun"
      "SUPER, E, exec, ${pkill} wofi || ${wofi-emoji}"
      "SUPER, V, exec, ${pkill} wofi || ${cliphist} list | ${wofi} --dmenu | ${cliphist} decode | ${wl-copy}"
    ];
  }
