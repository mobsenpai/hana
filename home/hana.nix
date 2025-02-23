{
  modules = {
    shell = {
      enable = true;
      sillyTools = true;
    };

    desktop = {
      windowManager = "Hyprland";
    };

    programs = {
      alacritty.enable = true;
      appflowy.enable = true;
      fastfetch.enable = true;
      firefox.enable = true;
      git.enable = true;
      helix.enable = true;
      hyprlock.enable = true;
      media.enable = true;
      ncspot.enable = true;
      pcmanfm.enable = true;
      waybar.enable = true;
      wofi.enable = true;
      zathura.enable = true;
    };

    services = {
      hypridle.enable = true;
      hyprpaper.enable = true;
      swaync.enable = true;
    };
  };
}
