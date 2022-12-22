{ config, pkgs, ... }:

{
  # xsession = {
  #   enable = true;
  #   windowManager.awesome = {
  #     enable = true;
  #     package = pkgs.awesome;
  #     # extraConfig = import ./rc-lua.nix;
  #   };
  # };
  # home.file.".config/awesome/rc.lua".source = ./rc.lua;
  # home.file = {
  #   ".config/awesome/rc.lua".source = ./rc.lua;
  #   ".config/awesome/modules/bling".source = inputs.bling.outPath;
  #   ".config/awesome/modules/rubato".source = inputs.rubato.outPath;
  # };
}
