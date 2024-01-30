{pkgs, ...}: {
  imports = [
    ./playerctld.nix
  ];

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
}
