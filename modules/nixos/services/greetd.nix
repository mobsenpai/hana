{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit
    (lib)
    utils
    mkIf
    getExe'
    ;
  cfg = config.modules.services.greetd;
in
  mkIf cfg.enable {
    assertions = utils.asserts [
      config.modules.system.desktop.enable
      "Greetd requires desktop to be enabled"
      (cfg.sessionDirs != [])
      "Greetd session dirs must be set"
    ];

    # TUIgreet stable 0.9.0 version is broken, hence using unstable
    # https://github.com/apognu/tuigreet/issues/140
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          user = "greeter";
          command = ''
            ${getExe' pkgs.unstable.greetd.tuigreet "tuigreet"} \
            --time \
            --sessions ${cfg.sessionDirs} \
            --remember \
            --remember-session
          '';
        };
      };
    };

    # These settings ensure that boot logs won't get spammed over greetd
    # https://github.com/apognu/tuigreet/issues/68#issuecomment-1586359960
    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };

    # Enable gnome keyring for saving login credentials in apps such as VSCode
    # Works with greetd through pam
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.greetd = {
      startSession = true;
      enableGnomeKeyring = true;
    };
  }
