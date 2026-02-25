{
  lib,
  config,
  ...
}: let
  cfg = config.modules.programs.localsend;
in
  lib.mkIf cfg.enable
  {
    programs.localsend.enable = true;
  }
