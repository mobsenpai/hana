{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) getExe hiPrio;
  inherit (config.modules.colorScheme) xcolors;
  cfg = config.modules.programs.alacritty;
in
  lib.mkIf cfg.enable
  {
    programs.alacritty = {
      enable = true;
      package = pkgs.alacritty-graphics;
      settings = {
        window = {
          padding = {
            x = 30;
            y = 30;
          };
          dynamic_padding = true;
          decorations = "none";
          dynamic_title = true;
        };

        font = {
          size = 10;
          normal.family = "FiraMono Nerd Font";
        };

        colors = {
          primary = {
            background = xcolors.base00;
            foreground = xcolors.base05;
          };

          cursor = {
            text = xcolors.base00;
            cursor = xcolors.base05;
          };

          selection = {
            background = xcolors.base02;
            text = "CellForeground";
          };

          normal = {
            black = xcolors.base01;
            red = xcolors.base08;
            green = xcolors.base0B;
            yellow = xcolors.base0A;
            blue = xcolors.base0D;
            magenta = xcolors.base0E;
            cyan = xcolors.base0C;
            white = xcolors.base06;
          };

          bright = {
            black = xcolors.base02;
            red = xcolors.base12;
            green = xcolors.base14;
            yellow = xcolors.base13;
            blue = xcolors.base16;
            magenta = xcolors.base17;
            cyan = xcolors.base15;
            white = xcolors.base07;
          };
        };

        mouse = {
          hide_when_typing = false;
        };

        cursor = {
          blink_interval = 500;
          style = {
            shape = "Beam";
            blinking = "On";
          };
        };
      };
    };

    home.packages = [
      # Modify the desktop entry to comply with the xdg-terminal-exec spec
      # https://gitlab.freedesktop.org/terminal-wg/specifications/-/merge_requests/3
      (hiPrio (
        pkgs.runCommand "alacritty-desktop-modify" {} ''
          mkdir -p $out/share/applications
          substitute ${pkgs.alacritty}/share/applications/Alacritty.desktop $out/share/applications/Alacritty.desktop \
            --replace-fail "Type=Application" "Type=Application
          X-TerminalArgAppId=--class
          X-TerminalArgDir=--working-directory
          X-TerminalArgHold=--hold
          X-TerminalArgTitle=--title"
        ''
      ))
    ];

    desktop = let
      alacritty = getExe config.programs.alacritty.package;
    in {
      niri.binds = {
        "Mod+Return" = {
          action.spawn = alacritty;
          hotkey-overlay.title = "Open alacritty";
        };
      };

      hyprland.settings = {
        bind = [
          "SUPER, Return, exec, ${alacritty}"
          "SUPER SHIFT, Return, exec, [float] ${alacritty}"
        ];

        windowrule = [
          "opacity 0.85, class:^(Alacritty)$"
        ];

        workspace = [
          "special:s1, gapsout:80, on-created-empty:alacritty"
        ];
      };
    };
  }
