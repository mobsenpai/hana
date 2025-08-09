{
  modules = {
    shell = {
      enable = true;
      sillyTools = true;
    };

    desktop = {
      terminal = "Alacritty";
      windowManager = "Niri";
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

    # Use styleguide
    # https://github.com/tinted-theming/base24/blob/main/styling.md
    colorScheme = {
      polarity = "dark";
      colors = {
        base00 = "1d1f21";
        base01 = "282a2e";
        base02 = "373b41";
        base03 = "969896";
        base04 = "b4b7b4";
        base05 = "c5c8c6";
        base06 = "e0e0e0";
        base07 = "ffffff";
        base08 = "cc6666";
        base09 = "de935f";
        base0A = "f0c674";
        base0B = "b5bd68";
        base0C = "8abeb7";
        base0D = "81a2be";
        base0E = "b294bb";
        base0F = "a3685a";
        base10 = "181a1b";
        base11 = "141516";
        base12 = "ff8888";
        base13 = "ffe082";
        base14 = "d6e685";
        base15 = "b4ffff";
        base16 = "a6c8ff";
        base17 = "d2aaff";
      };
    };
  };
}
