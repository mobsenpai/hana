{lib, ...}: let
  inherit (lib) utils mkEnableOption mkOption types;
in {
  imports = utils.scanPaths ./.;

  options.modules.system = {
    audio.enable = mkEnableOption "pipewire audio";
    bluetooth.enable = mkEnableOption "bluetooth";
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
