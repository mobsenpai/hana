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
    ./modules/programs/alacritty
    ./modules/programs/kitty.nix
    # ./modules/programs/mpd.nix
    # ./modules/programs/neovim.nix
    ./modules/programs/vscode.nix
    # ./modules/programs/zathura.nix

    (import ./modules/programs/firefox {
      inherit config pkgs;
      package = pkgs.firefox;
    })
  ];
}
