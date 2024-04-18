{
  config,
  lib,
  ...
}: {
  options = {
    myhome.wofi.enable = lib.mkEnableOption "enables wofi";
  };

  config = lib.mkIf config.myhome.wofi.enable {
    programs.wofi = {
      enable = true;
      settings = {
        allow_images = true;
        columns = 1;
        height = "55%";
        hide_scroll = true;
        image_size = 30;
        insensitive = true;
        layer = "top";
        location = "center";
        orientation = "vertical";
        prompt = "";
        width = "25%";
      };

      style = with config.myhome.colorscheme.xcolors; ''
        *{
          all: unset;
          font-family: JetBrainsMono Nerd Font;
          font-size: 10pt;
          font-weight: bold;
        }

        #window {
          background: ${black};
          border-radius: 8px;
          border: 2px solid ${orange};
        }

        #input {
          background: ${black};
          color: ${brightwhite};
          margin-bottom: 8px;
          padding: 2px;
        }

        #input > image.left {
          margin-right: 10px;
        }

        #outer-box {
          padding: 15px;
        }

        #text {
          color: ${brightwhite};
          margin-left: 4px;
        }

        #text:selected {
          color: ${darkbg};
        }

        #img {
          background: transparent;
        }

        #entry {
          border-radius: 8px;
          margin: 2px;
          padding: 4px;
        }

        #entry:selected {
          background: ${brightorange};
        }
      '';
    };
  };
}
