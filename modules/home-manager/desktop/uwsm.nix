{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.programs.uwsm.enable {
    # The tray Requires "graphical-session-pre.target" which is bad practice
    xdg.configFile."systemd/user/tray.target".enable = false;
    programs.bash = {
      shellAliases."xdg-open" = "app2unit-open-service";
      initExtra =
        # bash
        ''
          nix-run-app() {
            app2unit -t service -- "$@"
          }
        '';
    };
  };
}
