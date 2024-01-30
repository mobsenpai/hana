{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.self.homeManagerModules.misc.gtk
  ];

  home.packages = with pkgs; [
    grim
    gtklock
    slurp
    swappy
    swaybg
    swaynotificationcenter
    swayosd
    waybar
    wl-clipboard
    xdg-utils
  ];

  xdg = {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";
    mimeApps.enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
