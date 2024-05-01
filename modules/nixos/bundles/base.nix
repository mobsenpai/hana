{
  config,
  lib,
  ...
}: {
  options = {
    myNixos.base.enable = lib.mkEnableOption "Enables base";
  };

  config = lib.mkIf config.myNixos.base.enable {
    myNixos = {
      boot.enable = lib.mkDefault true;
      nix.enable = lib.mkDefault true;
      system-path.enable = lib.mkDefault true;
      users-group.enable = lib.mkDefault true;

      bash.enable = lib.mkDefault true;
      home-manager.enable = lib.mkDefault true;

      networking.enable = lib.mkDefault true;
    };
  };
}
