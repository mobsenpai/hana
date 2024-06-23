{lib, ...}: let
  inherit (lib) utils mkEnableOption mkOption types;
in {
  imports = utils.scanPaths ./.;

  options.modules.system = {
    audio.enable = mkEnableOption "pipewire audio";
    bluetooth.enable = mkEnableOption "bluetooth";
    desktop = {
      enable = mkEnableOption "desktop functionality";

      desktopEnvironment = mkOption {
        type = with types; nullOr (enum ["xfce" "plasma" "gnome"]);
        default = null;
        description = ''
          The desktop environment to use. The window manager is configured in
          home manager. Some windows managers don't require a desktop
          environment and some desktop environments include a window manager.
        '';
      };
    };

    device = {
      type = mkOption {
        type = types.enum ["laptop" "desktop" "server" "vm"];
        description = "The type/purpose of the device";
      };

      gpu = {
        type = mkOption {
          type = with types; nullOr (enum ["nvidia" "amd"]);
          default = null;
          description = ''
            The device's GPU manufacturer. Leave null if device does not have a
            dedicated GPU.
          '';
        };
      };
    };
  };
}
