{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./programs/alacritty.nix
    ./programs/firefox.nix
    ./programs/helix.nix
    ./programs/media
  ];

  home.packages = lib.attrValues {
    # Dev tools
    inherit
      (pkgs)
      alejandra
      nodejs
      ;
    inherit
      (pkgs.nodePackages)
      prettier
      typescript-language-server
      vscode-langservers-extracted
      ;

    # Utilities
    inherit
      (pkgs)
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
      ;
  };
}
