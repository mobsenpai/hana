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
