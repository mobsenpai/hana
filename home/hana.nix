# TODO: WIP
{inputs, ...}: {
  imports = [inputs.aoi.homeModules.default];
  services.aoi = {
    enable = true;
    pathfix = true;
    systemd = true;
  };
  modules = {
    shell = {
      enable = true;
      sillyTools = true;
    };

    desktop = {
      windowManager = "Hyprland";
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
      waybar.enable = false;
      wofi.enable = false;
      zathura.enable = true;
    };

    services = {
      cliphist.enable = false;
      hypridle.enable = true;
      hyprpaper.enable = true;
      swaync.enable = false;
    };

    colorScheme = {
      type = "dark";
      colors = {
        bg0 = "171719";
        bg1 = "252628";
        bg2 = "2E2F31";
        bg3 = "3A3A3D";
        bg4 = "48484C";

        fg0 = "E5E7ED";
        fg1 = "D1D3DB";
        fg2 = "BFC2CC";
        fg3 = "A7A9B3";
        fg4 = "6E6E72";

        gray0 = "6E6E72";
        gray1 = "8A8A8F";

        red0 = "F9AAB6";
        red1 = "F68B9D";

        green0 = "AAF9B0";
        green1 = "7EEA88";

        yellow0 = "F9F7AA";
        yellow1 = "F4F28B";

        blue0 = "A8C7FA";
        blue1 = "7EA8F5";

        purple0 = "DCADF9";
        purple1 = "BC8EE6";

        aqua0 = "AAF3F9";
        aqua1 = "7EE6F0";

        orange0 = "F9C5AA";
        orange1 = "F6B184";
      };
    };
  };
}
