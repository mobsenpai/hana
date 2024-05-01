{
  config,
  lib,
  ...
}: {
  options = {
    myNixos.general-desktop.enable = lib.mkEnableOption "Enables general-desktop";
  };

  config = lib.mkIf config.myNixos.base.enable {
    myNixos = {
      fontconfig.enable = lib.mkDefault true;
      i18n.enable = lib.mkDefault true;
      locale.enable = lib.mkDefault true;

      bluetooth.enable = lib.mkDefault true;

      gnome-keyring.enable = lib.mkDefault true;
      mtp.enable = lib.mkDefault true;
      pipewire.enable = lib.mkDefault true;
      polkit-gnome.enable = lib.mkDefault true;
    };
  };
}
