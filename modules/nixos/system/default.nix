{
  lib,
  config,
  ...
}: let
  inherit (lib) utils mkEnableOption mkOption types;
  inherit (config.modules.system) device;
in {
  imports = utils.scanPaths ./.;

  options.modules.system = {
    audio = {
      enable = mkEnableOption "pipewire audio";
      inputNoiseSuppression = mkEnableOption "input noise suppression source";
    };
    bluetooth.enable = mkEnableOption "bluetooth";
    device = {
      type = mkOption {
        type = types.enum ["laptop" "desktop"];
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

      battery = mkOption {
        type = with types; nullOr str;
        default = null;
        example = "BAT1";
        description = ''
          Name of the battery device in /sys/class/power_supply.
        '';
      };
    };
  };
}
