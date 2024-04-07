{pkgs, ...}: {
  imports = [
    ./networking.nix
    ./pipewire.nix
  ];

  services = {
    gvfs.enable = true;
    tumbler.enable = true;
    udev.packages = with pkgs; [android-udev-rules];
  };
}
