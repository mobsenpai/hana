# { config, theme, ... }:
{ config, ... }:

{
  programs.alacritty = {
    enable = true;
    # settings = import ./settings.nix { inherit theme; };
    settings = import ./alacritty-yml.nix;
  };
}