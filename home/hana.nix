{
  modules = {
    shell = {
      enable = true;
      sillyTools = true;
    };

    desktop = {
      terminal = "Alacritty";
      windowManager = "Niri";
      primaryBrowser = "Qutebrowser";
    };

    programs = {
      alacritty.enable = true;
      fastfetch.enable = true;
      firefox.enable = false;
      git.enable = true;
      helix.enable = true;
      hyprlock.enable = true;
      lb-tui.enable = true;
      media.enable = true;
      nautilus.enable = true;
      obsidian.enable = true;
      qutebrowser.enable = true;
      tofi.enable = true;
      waybar.enable = true;
      wofi.enable = false;
      zathura.enable = true;
    };

    services = {
      cliphist.enable = true;
      hypridle.enable = true;
      hyprpaper.enable = true;
      swaync.enable = true;
      syncthing.enable = true;
      wlsunset.enable = true;
    };

    colorScheme.preset = "tokyo-night-dark";
  };
}
