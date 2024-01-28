{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./programs/alacritty.nix
    ./programs/firefox.nix
    # ./programs/helix.nix
    # ./programs/rofi.nix
  ];

  home.packages = lib.attrValues {
    inherit
      (pkgs)
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
      feh
      mpv
      pcmanfm
      waybar
      zathura
      ;
  };
}
