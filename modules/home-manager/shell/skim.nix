{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf getExe;

  fd = getExe pkgs.fd;
  bat = getExe pkgs.bat;
in
  mkIf config.modules.shell.enable
  {
    programs.skim = {
      enable = true;
      defaultCommand = "${fd} -H --type f";
      changeDirWidgetCommand = "${fd} --type d --hidden --exclude .git";
      fileWidgetCommand = "${fd} --type f --hidden --exclude .git --exclude .cache";
      fileWidgetOptions = ["--preview '${bat} --style=numbers --color=always --line-range :500 {}'"];

      defaultOptions = [
        "--height 20%"
      ];
    };
  }
