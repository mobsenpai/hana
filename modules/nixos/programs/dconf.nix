{
  lib,
  config,
  ...
}: let
  cfg = config.modules.programs.dconf;
in
  lib.mkIf cfg.enable
  {
    programs.dconf.enable = true;
  }
