# { config, theme, ... }:
{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    # settings = import ./settings.nix { inherit theme; };
    settings = {
      # type = pkgs.formats.yaml { }.type;
      # default = { };
      import = ./alacritty-yaml.nix;

    };
  };
}