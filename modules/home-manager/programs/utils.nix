{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    myHome.utils.enable = lib.mkEnableOption "Enables utils";
  };

  config = lib.mkIf config.myHome.utils.enable {
    home.packages = with pkgs; [
      bottom
      cbonsai
      cmatrix
      curl
      fd
      file
      jq
      killall
      macchina
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
    ];

    programs = {
      bat.enable = true;
      eza.enable = true;
      dircolors.enable = true;
      fzf.enable = true;
      zoxide.enable = true;
    };
  };
}
