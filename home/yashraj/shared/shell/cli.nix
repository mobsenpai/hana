{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    bottom
    curl
    cmatrix
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
    zip
  ];

  programs = {
    bat = {
      enable = true;
      config = {
        pager = "never";
        style = "plain";
        theme = "base16";
      };
    };

    eza.enable = true;

    skim = {
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
