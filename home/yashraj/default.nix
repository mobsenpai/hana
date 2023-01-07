{
  config,
  outputs,
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
    ./modules/programs/firefox.nix
    ./modules/programs/vscode.nix
  ];
}
