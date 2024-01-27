{

  hyprland = {
    imports = [
      ./wayland/wm/hyprland
    ];
  };

  misc = {
    gtk = import ./misc/gtk.nix;
    themes = import ./misc/themes.nix;
    
  };

  shell = {
    imports = [
      ./programs/bash.nix
      ./programs/git.nix
      ./programs/starship.nix
      ./programs/utils.nix
      ./programs/xdg.nix #is it a program?
    ];
  };
}
