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

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          user = "greeter";
          command = ''
            ${getExe' pkgs.greetd.tuigreet "tuigreet"} \
            --time \
            --sessions ${cfg.sessionDirs} \
            --remember \
            --remember-session
          '';
        };
      };
    };
  }
