{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.attrValues {
    inherit
      (pkgs)
      coreutils
      curl
      du-dust
      file
      joshuto
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

  services = {
    playerctld.enable = true;
  };

  programs = {
    exa.enable = true;
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
