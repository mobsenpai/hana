{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    #duf
    #du-dust
    fd
    #file
    #joshuto
    ranger
    #ripgrep
    #yt-dlp
    dt-shell-color-scripts
  ];

  programs = {
    bat.enable = true;
    exa.enable = true;

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    dircolors = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
