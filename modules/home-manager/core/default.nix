{
  lib,
  username,
  ...
}: {
  imports = lib.utils.scanPaths ./.;

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "23.05";
  };

  systemd.user.startServices = "sd-switch";
}
