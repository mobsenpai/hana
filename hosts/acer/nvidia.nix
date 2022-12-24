{config, pkgs, ...}:
{
  services.xserver.videoDrivers = [ "nvidia" ];
  boot.blacklistedKernelModules = ["nouveau"];

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