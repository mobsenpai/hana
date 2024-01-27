{pkgs, ...}: {
  users.mutableUsers = false;
  users.users.yashraj = {
    initialPassword = "nixos";
    isNormalUser = true;
    extraGroups = ["audio" "networkmanager" "video" "wheel"];

    packages = [pkgs.home-manager];
  };
}
