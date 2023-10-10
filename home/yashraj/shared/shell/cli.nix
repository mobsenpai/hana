{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrValues {
    inherit
      (pkgs)
      bc
      bottom
      bunnyfetch
      catimg
      coreutils
      curl
      du-dust
      fd
      file
      jq
      killall
      man-pages
      man-pages-posix
      neofetch
      procs
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
