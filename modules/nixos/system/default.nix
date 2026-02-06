{lib, ...}: let
  inherit (lib) utils mkEnableOption mkOption types;
in {
  imports = utils.scanPaths ./.;

  options.modules.system = {
    audio = {
      enable = mkEnableOption "pipewire audio";
      inputNoiseSuppression = mkEnableOption "input noise suppression source";
    };

    bluetooth = {
      enable = mkEnableOption "bluetooth";
      applet.enable = mkEnableOption "Blueman system tray applet";
    };

    device = {
      type = mkOption {
        type = types.enum ["laptop" "desktop"];
        description = "The type/purpose of the device";
      };

      battery = mkOption {
        type = with types; nullOr str;
        default = null;
        example = "BAT1";
        description = ''
          Name of the battery device in /sys/class/power_supply.
        '';
      };

      cpu = {
        type = mkOption {
          type = types.enum [
            "intel"
            "amd"
          ];
          description = "The device's CPU manufacturer";
        };

        threads = mkOption {
          type = types.int;
          description = "The CPU thread count";
        };
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

      monitors = mkOption {
        type = types.listOf (types.submodule {
          options = {
            enabled = mkOption {
              type = types.bool;
              default = true;
              description = ''
                If the monitor should be disabled by default and enabled on-demand
                set this to false
              '';
            };

            name = mkOption {
              type = types.str;
              example = "DP-1";
            };

            number = mkOption {
              type = types.int;
            };

            width = mkOption {
              type = types.int;
              example = 2560;
            };

            height = mkOption {
              type = types.int;
              example = 1440;
            };

            scale = mkOption {
              type = types.float;
              default = 1.0;
            };

            refreshRate = mkOption {
              type = types.float;
              default = 60.0;
            };

            position = {
              x = mkOption {
                type = types.int;
                default = 0;
                description = "Relative x position of monitor from top left corner";
              };
              y = mkOption {
                type = types.int;
                default = 0;
                description = "Relative y position of monitor from top left corner";
              };
            };

            transform = mkOption {
              type = types.int;
              default = 0;
              description = "Rotation transform according to Hyprland's transform list";
            };

            isPrimary = mkOption {
              type = types.bool;
              default = false;
              description = "Whether this is the primary monitor for lockscreen sizing";
            };
          };
        });
        default = [];
      };
    };

    networking = {
      applet.enable = mkEnableOption "Iwgtk system tray applet";
      wireless = {
        enable = mkEnableOption "wireless";
        backend = mkOption {
          type = types.enum [
            "iwd"
            "wpa_supplicant"
          ];
          default = "iwd";
          description = "The wireless authentication backend to use.";
        };
      };

      firewall = {
        enable =
          mkEnableOption "Firewall"
          // {
            default = true;
          };
      };
    };
  };
}
