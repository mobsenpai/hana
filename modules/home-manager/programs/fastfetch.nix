{
  lib,
  config,
  ...
}: let
  cfg = config.modules.programs.fastfetch;
in
  lib.mkIf cfg.enable
  {
    programs.fastfetch = {
      enable = true;
      settings = {
        logo.source = "nixos_small";
        display.separator = " ›  ";
        modules = [
          "break"
          {
            type = "os";
            key = "OS  ";
            keyColor = "red";
          }
          {
            type = "kernel";
            key = "KER ";
            keyColor = "green";
          }
          {
            type = "shell";
            key = "SH  ";
            keyColor = "blue";
          }
          {
            type = "terminal";
            key = "TER ";
            keyColor = "magenta";
          }
          {
            type = "wm";
            key = "WM  ";
            keyColor = "cyan";
          }
          "break"
        ];
      };
    };

    programs.bash.initExtra = ''
      fastfetch
    '';

    programs.bash.shellAliases = {
      neofetch = "fastfetch";
    };
  }
