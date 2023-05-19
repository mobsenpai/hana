{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./xdg.nix
    ./zsh.nix
    ./starship.nix
    ./cli.nix
    ./git.nix
    ./nix.nix
  ];

  home = {
    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
    ];
  };
}
