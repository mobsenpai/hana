{ config, ... }:

{
  programs.awesome = {
    enable = true;
    # settings = import ./settings.nix { inherit theme; };
    # settings = import ./alacritty-yml.nix;
  };
}