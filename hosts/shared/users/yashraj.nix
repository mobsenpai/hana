{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = true;
  users.users.yashraj = {
    description = "Yash Raj";
    isNormalUser = true;
    shell = pkgs.zsh;
    initialPassword = "nixos";
    extraGroups =
      [
        "wheel"
        "networkmanager"
        "video"
        "audio"
        "nix"
        "systemd-journal"
      ]
      ++ ifTheyExist [
        # "mysql"
        # "docker"
        "git"
        # "libvirtd"
      ];

    # packages = [pkgs.home-manager];
  };
}
