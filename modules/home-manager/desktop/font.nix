{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.mkIf osConfig.modules.system.desktop.enable
{
  fonts.fontconfig.enable = true;

  home.packages = [pkgs.nerd-fonts.fira-mono];
}
