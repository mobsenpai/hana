{
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf config.programs.uwsm.enable {
    environment.systemPackages = [pkgs.app2unit];
    environment.sessionVariables = {
      APP2UNIT_SLICES = "a=app-graphical.slice b=background-graphical.slice s=session-graphical.slice";
      APP2UNIT_TYPE = "scope";
    };
  };
}
