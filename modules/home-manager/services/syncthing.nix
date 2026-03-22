{
  lib,
  config,
  ...
}: let
  cfg = config.modules.services.syncthing;
in
  lib.mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      extraOptions = [
        "--home=${config.xdg.configHome}/syncthing"
        "--gui-address=127.0.0.1:8384"
      ];
    };
  }
