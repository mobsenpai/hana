{
  lib,
  config,
  username,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.modules.core) homeManager;
  inherit (homeConfig.programs) hyprlock;
  homeConfig = config.home-manager.users.${username};
in {
  security.polkit.enable = true;

  security.pam.services = mkIf (homeManager.enable) {
    hyprlock = mkIf (hyprlock.enable) {};
  };
}
