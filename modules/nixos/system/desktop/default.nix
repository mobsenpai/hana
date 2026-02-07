{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf utils mkDefault mkEnableOption mkOption types;
  inherit (config.modules.core) homeManager;
  inherit (config.modules.system) device;
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
    hardware.graphics.enable = true;

    # We do not need these accessibility services
    # https://github.com/NixOS/nixpkgs/pull/329658
    services.speechd.enable = false;
    services.orca.enable = false;

    # Some apps may use this to optimise for power savings
    services.upower.enable = mkDefault (device.type == "laptop");

    # Service doesn't autostart otherwise https://github.com/NixOS/nixpkgs/issues/81138
    systemd.services.upower.wantedBy = mkIf config.services.upower.enable ["graphical.target"];

    # Enables wayland for all apps that support it
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    # Some apps like vscode need the keyring for saving credentials
    services.gnome.gnome-keyring.enable = true;

    # Necessary for xdg-portal home-manager module to work with useUserPackages enabled
    # https://github.com/nix-community/home-manager/pull/5184
    # NOTE: When https://github.com/nix-community/home-manager/pull/2548 gets
    # merged this may no longer be needed
    environment.pathsToLink = mkIf homeManager.enable [
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];
  };
}
