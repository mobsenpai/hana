{
  config,
  inputs,
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
  imports = [
    inputs.hypridle.homeManagerModules.hypridle
  ];

  options = {
    myhome.hypridle.enable = lib.mkEnableOption "Enables hypridle";
  };

  config = lib.mkIf config.myhome.hypridle.enable {
    services.hypridle = {
      enable = true;
      beforeSleepCmd = "${pkgs.systemd}/bin/loginctl lock-session";
      lockCmd = lib.getExe config.programs.hyprlock.package;

      listeners = [
        {
          timeout = 300;
          onTimeout = suspendScript.outPath;
        }
      ];
    };
  };
}
