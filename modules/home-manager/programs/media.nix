{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    myhome.media.enable = lib.mkEnableOption "Enables media";
  };

  config = lib.mkIf config.myhome.media.enable {
    services = {
      playerctld.enable = true;
    };

    home.packages = with pkgs; [
      imv
      mpv
      pavucontrol
      playerctl
    ];

    xdg.mimeApps.defaultApplications = {
      "audio/*" = "mpv.desktop";
      "image/*" = "imv.desktop";
      "video/*" = "mpv.desktop";
    };
  };
}
