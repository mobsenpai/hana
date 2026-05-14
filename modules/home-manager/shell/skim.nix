{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf getExe;
  cfg = config.modules.shell;
in
  mkIf cfg.enable
  {
    programs.skim = let
      fd = getExe pkgs.fd;
      bat = getExe pkgs.bat;
    in {
      enable = true;
      enableBashIntegration = true;
      defaultCommand = "${fd} -H --type f";
      changeDirWidgetCommand = "${fd} --type d --hidden --exclude .git";
      fileWidgetCommand = "${fd} --type f --hidden --exclude .git --exclude .cache";
      fileWidgetOptions = ["--preview '${bat} --style=numbers --color=always --line-range :500 {}'"];
      historyWidgetOptions = [
        "--no-sort"
      ];

      defaultOptions = [
        "--height 20%"
      ];
    };
  }
