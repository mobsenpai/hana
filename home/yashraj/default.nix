{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./home.nix
    ./packages.nix

    ./modules/colorschemes
    ./modules/shell
    ./modules/desktop/windowManagers/awesome
    ./modules/programs/alacritty.nix
    ./modules/programs/vscode.nix
    ./modules/programs/firefox.nix
    # ./modules/programs/mpd.nix
    # ./modules/programs/neovim.nix
    # ./modules/programs/zathura.nix
  ];
}
