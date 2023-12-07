{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    bottom
    catimg
    curl
    cmatrix
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
  ];

  programs = {
    eza.enable = true;

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
