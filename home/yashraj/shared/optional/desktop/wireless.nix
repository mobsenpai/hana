{pkgs, ...}: {
  home.packages = with pkgs; [networkmanagerapplet blueman];
  services = {
    network-manager-applet.enable = true;
    blueman-applet.enable = true;
  };
}
