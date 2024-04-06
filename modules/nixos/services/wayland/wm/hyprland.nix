{
  inputs,
  pkgs,
  ...
}: {
  imports = [
  ];

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
      hyprlock.text = "auth include login";
    };
    polkit.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
}
