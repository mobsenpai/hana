{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.self.homeManagerModules.misc.gtk
  ];

  home.packages = lib.attrValues {
    inherit
      (pkgs)
      grim
      gtk3 # For gtk-launch
      imv
      slurp
      swappy
      swaybg
      swaynotificationcenter
      swayosd
      gtklock
      wl-clipboard
      ;
  };

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
  };
}
