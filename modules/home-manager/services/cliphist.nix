{
  lib,
  config,
  ...
}: let
  cfg = config.modules.services.cliphist;
in
  lib.mkIf cfg.enable {
    services.cliphist.enable = true;
  }
