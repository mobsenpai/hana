{
  lib,
  pkgs,
  osConfig,
  ...
}:
lib.mkIf osConfig.modules.programs.gaming.enable {
  home.packages = [pkgs.r2modman];
}
