{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrValues {
    inherit
      (pkgs)
      gotop
      coreutils
      curl
      du-dust
      file
      jq
      killall
      man-pages
      man-pages-posix
      neofetch
      procs
      ranger
      ripgrep
      trash-cli
      tree
      unrar
      unzip
      util-linux
      wget
      zip
      yt-dlp
      ;
  };

  programs = {
    eza.enable = true;
    man.enable = true;

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
