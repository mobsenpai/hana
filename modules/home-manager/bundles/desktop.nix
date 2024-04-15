{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    myhome.desktop.enable = lib.mkEnableOption "enables desktop";
  };

  config = lib.mkIf config.myhome.desktop.enable {
    myhome = {
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
  };
}