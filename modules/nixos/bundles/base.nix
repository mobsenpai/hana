{
  config,
  lib,
  ...
}: {
  options = {
    mynixos.base.enable = lib.mkEnableOption "enables base";
  };

  config = lib.mkIf config.mynixos.base.enable {
    mynixos = {
      # Config
      fontconfig.enable = lib.mkDefault true;
      i18n.enable = lib.mkDefault true;
      locale.enable = lib.mkDefault true;
      boot.enable = lib.mkDefault true;
      nix.enable = lib.mkDefault true;
      system-path.enable = lib.mkDefault true;
      users-group.enable = lib.mkDefault true;

      # Hardware
      bluetooth.enable = lib.mkDefault true;

      # Programs
      bash.enable = lib.mkDefault true;
      home-manager.enable = lib.mkDefault true;

      # Services
      mtp.enable = lib.mkDefault true;
      networking.enable = lib.mkDefault true;
      pipewire.enable = lib.mkDefault true;
    };
  };
}
