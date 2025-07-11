{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf utils mkEnableOption optionals;
  cfg = config.modules.shell;
in {
  imports = utils.scanPaths ./.;

  options.modules.shell = {
    enable = mkEnableOption "custom shell environment";
    sillyTools = mkEnableOption "installation of silly shell tools";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs;
      [
        bat
        bottom
        curl
        fd
        file
        jq
        killall
        ripgrep
        trash-cli
        unrar
        unzip
        vim
        wget
        yazi
        yt-dlp
        zathura
        zip
      ]
      ++ optionals cfg.sillyTools (with pkgs; [
        cbonsai
        cmatrix
        pipes-rs
        tty-clock
      ]);

    home.sessionVariables.COLORTERM = "truecolor";
  };
}
