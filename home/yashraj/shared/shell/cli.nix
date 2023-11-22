{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrValues {
    inherit
      (pkgs)
      bottom
      catimg
      curl
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
      yt-dlp
      zip
      ;
  };

  programs = {
    exa.enable = true;

    bat = {
      enable = true;
      config = {
        pager = "never";
        style = "plain";
        theme = "base16";
      };
    };

    fzf = {
      enable = true;
      enableBashIntegration = true;
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };

    dircolors = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
