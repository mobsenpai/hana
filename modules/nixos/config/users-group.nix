{
  config,
  lib,
  ...
}: {
  options = {
    myNixos.users-group.enable = lib.mkEnableOption "Enables users-group";
  };

  config = lib.mkIf config.myNixos.users-group.enable {
    users.mutableUsers = false;
    users.users.yashraj = {
      initialPassword = "nixos";
      isNormalUser = true;
      extraGroups = ["audio" "networkmanager" "video" "wheel"];
    };
  };
}
