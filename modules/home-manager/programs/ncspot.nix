{
  lib,
  config,
  ...
}: let
  cfg = config.modules.programs.ncspot;
in
  lib.mkIf cfg.enable
  {
    programs.ncspot = {
      enable = true;
    };
  }
