{
  config,
  lib,
  pkgs,
  ...
}: let
  suspendScript = pkgs.writeShellScript "suspend-script" ''
    ${pkgs.pipewire}/bin/pw-cli i all 2>&1 | ${pkgs.ripgrep}/bin/rg running -q
    # Only suspend if audio isn't running
    if [ $? == 1 ]; then
      ${pkgs.systemd}/bin/systemctl suspend
    fi
  '';
in {
  options = {
    myHome.hypridle.enable = lib.mkEnableOption "Enables hypridle";
  };

  config = lib.mkIf config.myHome.hypridle.enable {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session";
          lock_cmd = "${pkgs.hyprlock}/bin/hyprlock";
        };

        listener = [
          {
            timeout = 1800;
            on-timeout = suspendScript.outPath;
          }
        ];
      };
    };
  };
}
