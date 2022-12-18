{ config, pkgs, ... }:

{
  xsession = {
    enable = true;
    windowManager.awesome = {
      enable = true;
      package = pkgs.awesome;
      settings = import ./rc-lua.nix;
    };
  };
}
