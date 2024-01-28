{inputs, ...}: {
  home-manager.sharedModules = [
    inputs.self.homeManagerModules.hyprland
  ];

  programs.hyprland.enable = true;

  security = {
    pam.services = {
      gtklock = {};
    };

    polkit.enable = true;
  };
}
