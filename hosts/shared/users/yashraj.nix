{
  pkgs,
  config,
  lib,
  outputs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.yashraj = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Yash Raj";
    initialPassword = "nixos";
    extraGroups =
      [
        "wheel"
        "video"
        "audio"
        "input"
        "networkmanager"
      ]
      ++ ifTheyExist [
        "network"
        "git"
      ];

    uid = 1000;
    packages = [pkgs.home-manager];
  };

  home-manager.users.yashraj = import ../../../home/yashraj;
}
