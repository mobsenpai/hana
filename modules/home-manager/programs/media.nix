{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    myHome.media.enable = lib.mkEnableOption "Enables media";
  };

  config = lib.mkIf config.myHome.media.enable {
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
