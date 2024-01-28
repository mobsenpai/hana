lib: {
  colorscheme = rec {
    colors = {
      base00 = "282828";
      base01 = "3c3836";
      base02 = "504945";
      base03 = "665c54";
      base04 = "bdae93";
      base05 = "d5c4a1";
      base06 = "ebdbb2";
      base07 = "fbf1c7";
      base08 = "fb4934";
      base09 = "fe8019";
      base0A = "fabd2f";
      base0B = "b8bb26";
      base0C = "8ec07c";
      base0D = "83a598";
      base0E = "d3869b";
      base0F = "d65d0e";
    };

    xcolors = lib.mapAttrsRecursive (_: color: "#${color}") colors;
  };

  #   wallpaper = builtins.fetchurl rec {
  #     name = "wallpaper-${sha256}.png";
  #     url = "https://media.githubusercontent.com/media/rxyhn/wallpapers/main/OS/NixOS/nixos-nineish-gradient.png";
  #     sha256 = "1g6h95qbn74n4yhvbch61lpg2nwcmr8kaz1lx566rd58q9jmh755";
  #   };
}
