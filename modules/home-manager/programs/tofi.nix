{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf getExe getExe';
  inherit (config.modules.colorScheme) xcolors;
  cfg = config.modules.programs.tofi;
in
  mkIf cfg.enable {
    programs.tofi = {
      enable = true;
      settings = {
        anchor = "bottom";
        width = "100%";
        height = 27;
        horizontal = true;
        font-size = 10;
        font = "monospace";
        prompt-text = "Enter Input : ";
        placeholder-text = "input";
        outline-width = 0;
        border-width = 1;
        result-spacing = 8;
        padding-left = 3;
        padding-right = 3;
        padding-top = 3;
        padding-bottom = 3;
        selection-background-padding = 4;

        background-color = xcolors.base00;
        text-color = xcolors.base05;
        border-color = xcolors.base02;
        selection-color = xcolors.base0D;
        selection-background = xcolors.base02;
      };
    };

    desktop = let
      pkill = getExe' pkgs.procps "pkill";
      tofi = getExe' config.programs.tofi.package "tofi";
      tofi-run = getExe' config.programs.tofi.package "tofi-run";
      rofimoji = getExe pkgs.rofimoji;
      cliphist = getExe pkgs.cliphist;
      wl-copy = getExe' pkgs.wl-clipboard "wl-copy";
      app2unit = getExe pkgs.app2unit;
    in {
      niri.binds = with config.lib.niri.actions; {
        "Mod+A" = {
          repeat = false;
          action =
            spawn "sh" "-c"
            "${pkill} tofi-run || true; cmd=$(${tofi-run}); [ -n \"$cmd\" ] && ${app2unit} -t service -- $cmd";
          hotkey-overlay.title = "Open launcher";
        };

        "Mod+E" = {
          repeat = false;
          action = spawn "sh" "-c" "${pkill} tofi || ${rofimoji} --selector tofi";
          hotkey-overlay.title = "Open emoji picker";
        };

        "Mod+V" = {
          repeat = false;
          action = spawn "sh" "-c" "${pkill} tofi || ${cliphist} list | ${tofi} | ${cliphist} decode | ${wl-copy}";
          hotkey-overlay.title = "Open clipboard";
        };
      };

      hyprland.settings.binddr = [
        "SUPER, A, Open launcher, exec, ${pkill} tofi-run || true; cmd=$(${tofi-run}); [ -n \"$cmd\" ] && ${app2unit} -t service -- $cmd"
        "SUPER, E, Open emoji picker, exec, ${pkill} tofi || ${rofimoji} --selector tofi"
        "SUPER, V, Open clipboard, exec, ${pkill} tofi || ${cliphist} list | ${tofi} | ${cliphist} decode | ${wl-copy}"
      ];
    };
  }
