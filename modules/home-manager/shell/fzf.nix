{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf getExe;
  inherit (config.modules.colorScheme) xcolors;
  fd = getExe pkgs.fd;
  bat = getExe pkgs.bat;
in
  mkIf config.modules.shell.enable
  {
    programs.fzf = {
      enable = true;
      defaultCommand = "${fd} -H --type f";
      changeDirWidgetCommand = "${fd} --type d --hidden --exclude .git";
      changeDirWidgetOptions = [];
      fileWidgetCommand = "${fd} --type f --hidden --exclude .git --exclude .cache";
      fileWidgetOptions = ["--preview '${bat} --style=numbers --color=always --line-range :500 {}'"];

      defaultOptions = [
        "--height 20%"
        "--bind ctrl-p:preview-up,ctrl-n:preview-down,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down"
        "--border rounded"
      ];

      colors = {
        bg = "-1";
        "bg+" = "-1";
        fg = "${xcolors.fg3}";
        "fg+" = "${xcolors.fg1}";
        hl = "${xcolors.blue1}";
        "hl+" = "${xcolors.blue1}";
        spinner = "${xcolors.aqua1}";
        header = "${xcolors.blue1}";
        info = "${xcolors.yellow1}";
        pointer = "${xcolors.aqua1}";
        marker = "${xcolors.aqua1}";
        prompt = "${xcolors.yellow1}";
      };
    };
  }
