{ config, pkgs, ... }:

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

  # home.file.".config/awesome/rc.lua".source = ./rc.lua;
  # home.file = {
  #   # ".config/awesome/rc.lua".source = ./rc.lua;
  #   ".config/awesome/rc.lua".source = ./rc2.lua;
  #   # ".config/awesome/modules/bling".source = inputs.bling.outPath;
  #   # ".config/awesome/modules/rubato".source = inputs.rubato.outPath;
  # };

  # imports = [
  #   ../../dunst
  #   ../../gtk.nix
  #   ../../rofi.nix
  # ];
}
