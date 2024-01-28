{pkgs, ...}: {
  imports = [
    ./networking.nix
    ./pipewire.nix
  ];

  services = {
    gvfs.enable = true;
  };
}
