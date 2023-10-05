{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.xserver.windowManager.awesome;
  luaModules = lib.attrValues {
    inherit
      (pkgs.luaPackages)
      lgi
      ;
  };
in {
  config = mkIf cfg.enable {
    environment.systemPackages = lib.attrValues {
      inherit
        (pkgs)
        brightnessctl
        feh
        pcmanfm
        xclip
        xss-lock
        xlockmore
        scrot
        gscreenshot
        ;
    };
  };
}
