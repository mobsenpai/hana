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
          gradient_color_1 = "'${xcolors.base0D}'";
          gradient_color_2 = "'${xcolors.base0B}'";
          gradient_color_3 = "'${xcolors.base0A}'";
          gradient_color_4 = "'${xcolors.base0C}'";
          gradient_color_5 = "'${xcolors.base0E}'";
          gradient_color_6 = "'${xcolors.base09}'";
          gradient_color_7 = "'${xcolors.base08}'";
        };
      };
    };
  }
