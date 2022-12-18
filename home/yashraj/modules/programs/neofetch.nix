{ config, ... }:

{
  programs.neofetch = {
    enable = true;
    # settings = import ./settings.nix { inherit theme; };
    settings = import ./config-conf.nix;
  };
}