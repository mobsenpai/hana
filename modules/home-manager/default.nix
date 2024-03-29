{
  flake.homeManagerModules = {
    hyprland = {
      imports = [
        ./wayland/wm/hyprland
      ];
    };

    misc = {
      gtk = import ./misc/gtk.nix;
    };

    shell = {
      imports = [
        ./programs/bash.nix
        ./programs/git.nix
        ./programs/starship.nix
        ./programs/utils.nix
      ];
    };
  };
}
