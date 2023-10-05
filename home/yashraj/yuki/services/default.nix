{
  services = {
    clipmenu = {
      enable = true;
      launcher = "rofi";
    };

    network-manager-applet.enable = true;

    picom = {
      enable = true;
      backend = "glx";
      vSync = true;
      shadow = false;
      settings = {
        animations = true;
        animation-stiffness = 300;
        animation-window-mass = 0.7;
        animation-dampening = 20;
        animation-clamping = true;
        animation-for-open-window = "zoom"; #open window
        animation-for-unmap-window = "zoom"; #minimize window
        animation-for-menu-window = "zoom";
        animation-for-transient-window = "zoom"; #popup windows
        animation-for-workspace-switch-in = "zoom"; #the windows in the workspace that is coming in
        animation-for-workspace-switch-out = "zoom"; #the windows in the workspace that are coming out
        # corner-radius = 15;
      };
    };
  };
}
