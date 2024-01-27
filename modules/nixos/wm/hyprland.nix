{inputs, ...}: {

    home-manager.sharedModules = [
    inputs.self.homeManagerModules.hyprland
  ];

    programs.hyprland.enable = true;
    
}