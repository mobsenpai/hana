{ config, ... }:

{
  programs.neofetch = {
    enable = true;
    # settings = import ./settings.nix { inherit theme; };
    # extraConfig = import ./config-conf.nix;
  };
}