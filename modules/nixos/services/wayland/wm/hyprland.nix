{
  inputs,
  pkgs,
  ...
}: {
  environment = {
    variables = {
      QT_QPA_PLATFORM = "wayland;xcb";
    };

    systemPackages = with pkgs; [
      pcmanfm
    ];
  };

  home-manager.sharedModules = [
    inputs.self.homeManagerModules.hyprland
  ];

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  security = {
    pam.services = {
      gtklock = {};
    };

    polkit.enable = true;
  };
}
