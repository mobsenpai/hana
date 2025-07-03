{
  modules = {
    shell = {
      enable = true;
      sillyTools = true;
    };

    desktop = {
      windowManager = "Niri";
      # TODO: change
      wallpaper.default = builtins.fetchurl {
        url = "https://images.unsplash.com/photo-1497042915201-daf0dd6fdc09?auto=format&fit=crop&w=1366&h=768&q=80";
        name = "wallpaper";
        sha256 = "1hib3ibr053bp1s0j1vwv65670hpzml5flpqkpzf0dq7li0b2yyg";
      };
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
    };

    # TODO: change
    colorScheme = {
      polarity = "dark";
      colors = {
        # Backgrounds
        bg0 = "1E1E1E"; # Main background
        bg1 = "241F31"; # Slightly lighter, from Adwaita palette
        bg2 = "2E3436"; # Even lighter (not in Adwaita, but common in GNOME)
        bg3 = "3A3A3D"; # Custom, slightly lighter still
        bg4 = "48484C"; # Custom, even lighter

        # Foregrounds
        fg0 = "FFFFFF"; # Main foreground
        fg1 = "C0BFBC"; # Secondary foreground (Adwaita light gray)
        fg2 = "BFC2CC"; # Custom, slightly darker
        fg3 = "A7A9B3"; # Custom, even darker
        fg4 = "6E6E72"; # Custom, darkest

        # Grays
        gray0 = "5E5C64"; # Adwaita dark gray
        gray1 = "8A8A8F"; # Custom, lighter gray

        # Reds
        red0 = "C01C28"; # Adwaita red
        red1 = "ED333B"; # Adwaita bright red

        # Greens
        green0 = "2EC27E"; # Adwaita green
        green1 = "57E389"; # Adwaita bright green

        # Yellows
        yellow0 = "F5C211"; # Adwaita yellow
        yellow1 = "F8E45C"; # Adwaita bright yellow

        # Blues
        blue0 = "1E78E4"; # Adwaita blue
        blue1 = "51A1FF"; # Adwaita bright blue

        # Purples
        purple0 = "9841BB"; # Adwaita purple
        purple1 = "C061CB"; # Adwaita bright purple

        # Aquas/Cyans
        aqua0 = "0AB9DC"; # Adwaita cyan
        aqua1 = "4FD2FD"; # Adwaita bright cyan

        # Oranges (not a main Adwaita color, but plausible GNOME accent)
        orange0 = "F57900"; # GNOME orange
        orange1 = "F6B184"; # Custom, lighter orange
      };
    };
  };
}
