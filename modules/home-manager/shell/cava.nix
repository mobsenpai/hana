{
  lib,
  config,
  ...
}: let
  inherit (config.modules.colorScheme) xcolors;
  cfg = config.modules.shell;
in
  lib.mkIf cfg.sillyTools
  {
    programs.cava = {
      enable = true;
      settings = {
        general = {
          bar_width = 1;
          bar_spacing = 0;
        };

        color = {
          gradient = 7;
          gradient_color_1 = "'${xcolors.blue0}'";
          gradient_color_2 = "'${xcolors.green0}'";
          gradient_color_3 = "'${xcolors.yellow0}'";
          gradient_color_4 = "'${xcolors.aqua0}'";
          gradient_color_5 = "'${xcolors.purple0}'";
          gradient_color_6 = "'${xcolors.orange0}'";
          gradient_color_7 = "'${xcolors.red0}'";
        };
      };
    };
  }
