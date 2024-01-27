{
  base = {
    imports = [
      ./config
    ];
  };

  hyprland = import ./wm/hyprland.nix;
  
}
