{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    myHome.desktop.enable = lib.mkEnableOption "Enables desktop";
  };

  config = lib.mkIf config.myHome.desktop.enable {
    myHome = {
      base.enable = lib.mkDefault true;

      alacritty.enable = lib.mkDefault true;
      base-dev.enable = lib.mkDefault true;
      firefox.enable = lib.mkDefault true;
      helix.enable = lib.mkDefault true;
      media.enable = lib.mkDefault true;
    };

    home.packages = with pkgs; [
      appflowy
    ];

    xdg.mimeApps.defaultApplications = {
      "inode/directory" = "pcmanfm.desktop";
    };
  };
}
