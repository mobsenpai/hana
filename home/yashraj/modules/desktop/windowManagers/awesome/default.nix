{ config, pkgs, inputs, ... }:

{
  home = {
    sessionVariables = {
      BROWSER = "firefox";
      EDITOR = "nvim";
      XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";

      # QT Variables
      # QT_QPA_PLATFORMTHEME = "qt5ct";
      # QT_STYLE_OVERRIDE = "kvantum";

      # Theming Related Variables
      # GTK_THEME = "Catppuccin-Mocha-Standard-Mauve-Dark";
      XCURSOR_SIZE = "24";
    };

    file = {
      ".config/awesome/rc.lua".source = ./rc2.lua;
      ".config/awesome/modules/bling".source = inputs.bling.outPath;
    };

  };

  # xsession = {
  #   enable = true;
  #   windowManager.awesome = {
  #     enable = true;
  #     package = pkgs.awesome;
  #     # extraConfig = import ./rc-lua.nix;
  #   };
  # };

  imports = [
    # ../../dunst
    # ../../gtk.nix
    # ../../rofi.nix
  ];
}
