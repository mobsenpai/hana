{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.modules.system) desktop;
  inherit (config.modules.system.device) gpu;
in
  mkIf (gpu.type == "nvidia") {
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        nvidia-vaapi-driver
      ];
    };

    services.xserver.videoDrivers = mkIf desktop.enable ["nvidia"];

    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      open = true;
      nvidiaSettings = false; # does not work on wayland
      powerManagement.enable = true;
    };
  }
