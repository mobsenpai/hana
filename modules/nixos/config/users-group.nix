{
  config,
  lib,
  ...
}: {
  options = {
    mynixos.users-group.enable = lib.mkEnableOption "Enables users-group";
  };

  config = lib.mkIf config.mynixos.users-group.enable {
    users.mutableUsers = false;
    users.users.yashraj = {
      initialPassword = "nixos";
      isNormalUser = true;
      extraGroups = ["audio" "networkmanager" "video" "wheel"];
    };
  };
}
