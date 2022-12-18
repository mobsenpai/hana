{ config, pkgs, ... }:

{
  xsession = {
    enable = true;
    windowManager.awesome = {
      enable = true;
      package = pkgs.awesome;
      # extraConfig = import ./rc-lua.nix;
    };
  };
}
