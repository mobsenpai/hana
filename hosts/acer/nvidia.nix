{
  config,
  pkgs,
  ...
}: {
  services.xserver.videoDrivers = ["nvidia"];
  boot.blacklistedKernelModules = ["nouveau"];
  # boot.kernelModules = ["nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm"];

  # environment = {
  #   variables = {
  #     LIBVA_DRIVER_NAME = "iHD";
  #     VDPAU_DRIVER = "va_gl";
  #   };
  # };
  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
      modesetting.enable = true;
      powerManagement.enable = true;
    };

    opengl = {
      extraPackages = with pkgs; [nvidia-vaapi-driver];
    };
  };
}
