{
  config,
  lib,
  pkgs,
  ...
}: let
  powermenu = pkgs.writeShellScriptBin "powermenu" ''
    #!/usr/bin/env bash

    op=$( echo -e " Poweroff\n Reboot\n Suspend\n Lock\n Logout" | wofi -i --dmenu | awk '{print tolower($2)}' )

    case $op in
            poweroff)
                    ;&
            reboot)
                    ;&
            suspend)
                    ${pkgs.systemd}/bin/systemctl $op
                    ;;
            lock)
    		            ${pkgs.systemd}/bin/loginctl lock-session
                    ;;
            logout)
                    ${pkgs.systemd}/bin/loginctl terminate-user $USER
                    ;;
    esac
  '';
in {
  options = {
    myHome.powermenu.enable = lib.mkEnableOption "Enables powermenu";
  };

  config = lib.mkIf config.myHome.powermenu.enable {
    home.packages = [powermenu];
  };
}
