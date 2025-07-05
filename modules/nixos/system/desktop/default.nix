{
  lib,
  config,
  ...
}: let
  inherit (lib) utils mkIf mkEnableOption mkOption types;
  inherit (config.modules.core) homeManager;
  cfg = config.modules.system.desktop;
in {
  imports = utils.scanPaths ./.;

  options.modules.system.desktop = {
    enable = mkEnableOption "desktop functionality";

    desktopEnvironment = mkOption {
      type = with types; nullOr (enum ["gnome"]);
      default = null;
      description = ''
        The desktop environment to use. The window manager is configured in
        home manager. Some windows managers don't require a desktop
        environment and some desktop environments include a window manager.
      '';
    };
  };

  config = mkIf cfg.enable {
    # Enables wayland for all apps that support it
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    # Some apps like vscode need the keyring for saving credentials
    services.gnome.gnome-keyring.enable = true;

    # https://github.com/JManch/nixos/blob/79498794ea4eb1b1dea797ec853ff2a29e0cb0df/modules/nixos/system/desktop/root.nix#L94
    environment.pathsToLink = mkIf homeManager.enable [
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];
  };
}
