{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    myHome.clipboard.enable = lib.mkEnableOption "Enables clipboard";
  };

  config = lib.mkIf config.myHome.clipboard.enable {
    systemd.user.services = {
      cliphist = {
        Unit = {
          Description = "Clipboard history service";
          PartOf = ["graphical-session.target"];
          After = ["graphical-session.target"];
        };

        Service = {
          ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store";
          Restart = "always";
        };

        Install.WantedBy = ["graphical-session.target"];
      };

      wl-clip-persist = {
        Unit = {
          Description = "Persistent clipboard for Wayland";
          PartOf = ["graphical-session.target"];
          After = ["graphical-session.target"];
        };

        Service = {
          ExecStart = "${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard both";
          Restart = "always";
        };

        Install.WantedBy = ["graphical-session.target"];
      };
    };
  };
}
