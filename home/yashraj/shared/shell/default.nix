{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./bash.nix
    ./cli.nix
    ./git.nix
    ./starship.nix
    ./xdg.nix
  ];

  home = {
    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
    ];

    sessionVariables = {
      EDITOR = "hx";
    };
  };
}
