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
