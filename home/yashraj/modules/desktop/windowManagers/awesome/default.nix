{
  config,
  pkgs,
  inputs,
  ...
}: {
  home = {
    sessionVariables = {
      BROWSER = "firefox";
      EDITOR = "nvim";
    };

    file = {
      # ".config/awesome/rc.lua".source = ./rc.lua;
      ".config/awesome/lain".source = inputs.lain.outPath;
      # ".config/awesome/modules/bling".source = inputs.bling.outPath;
      # ".config/awesome/modules/freedesktop".source = inputs.freedesktop.outPath;
    };
  };

  imports = [
    # ../../dunst
    ../../gtk.nix
    ../../picom.nix
    # ../../rofi.nix
  ];
}
