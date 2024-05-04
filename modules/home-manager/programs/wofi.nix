{
  config,
  lib,
  ...
}: {
  options = {
    myHome.wofi.enable = lib.mkEnableOption "Enables wofi";
  };

  config = lib.mkIf config.myHome.wofi.enable {
    programs.wofi = {
      enable = true;
      settings = {
        columns = 1;
        height = "55%";
        hide_scroll = true;
        insensitive = true;
        layer = "top";
        location = "center";
        orientation = "vertical";
        prompt = "";
        width = "25%";
      };

      style = with config.myHome.colorscheme; ''
        *{
          all: unset;
          font-family: "FiraMono Nerd Font";
          font-size: 10pt;
          font-weight: normal;
        }

        #window {
          background: ${xcolors.bg1};
          border-radius: 8px;
          border: 1px solid ${xcolors.bg2};
        }

        #input {
          background: ${xcolors.bg1};
          border-bottom: 1px solid ${xcolors.bg2};
          color: ${xcolors.fg1};
          margin-bottom: 4px;
          padding: 4px;
        }

        #input > image.left {
          margin-right: 4px;
        }

        #input > image.right  {
          margin-left: 4px;
        }

        #outer-box {
          padding: 4px;
        }

        #text {
          color: ${xcolors.fg1};
        }

        #entry {
          border-radius: 4px;
          padding: 4px;
        }

        #entry:selected {
          background: ${xcolors.bg2};
        }
      '';
    };
  };
}
