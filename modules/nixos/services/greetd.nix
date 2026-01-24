{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf utils getExe';
  inherit (config.modules.system) desktop;
  cfg = config.modules.services.greetd;
in
  mkIf cfg.enable {
    assertions = utils.asserts [
      (desktop.enable or false)
      "Greetd requires desktop to be enabled"
      (desktop.desktopEnvironment == null)
      "Do not enable greetd when using a desktop environment as it brings its own display manager"
    ];

    services.greetd = let
      tuigreet = getExe' pkgs.tuigreet "tuigreet";
    in {
      enable = true;
      settings = {
        default_session = {
          user = "greeter";
          command = ''
            ${tuigreet} \
            --time \
            --sessions ${cfg.sessionDirs} \
            --remember \
            --remember-session
          '';
        };
      };
    };
  }
