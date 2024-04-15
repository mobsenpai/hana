{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    myhome.utils.enable = lib.mkEnableOption "enables utils";
  };

  config = lib.mkIf config.myhome.utils.enable {
    home.packages = with pkgs; [
      bottom
      cmatrix
      curl
      fd
      file
      jq
      killall
      neofetch
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

      dircolors = {
        enable = true;
        enableBashIntegration = true;
      };

      skim = {
        enable = true;
        enableBashIntegration = true;
      };

      zoxide = {
        enable = true;
        enableBashIntegration = true;
      };
    };
  };
}
