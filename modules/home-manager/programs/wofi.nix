{
  config,
  lib,
  ...
}: {
  options = {
    myhome.wofi.enable = lib.mkEnableOption "Enables wofi";
  };

  config = lib.mkIf config.myhome.wofi.enable {
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

      style = with config.myhome.colorscheme; ''
        *{
          all: unset;
          font-family: "Fira Mono Nerd Font";
          font-size: 10pt;
          font-weight: normal;
        }

        #window {
          background: ${xcolors.soft-black};
          border-radius: 8px;
          border: 1px solid ${xcolors.light-black};
        }

        #input {
          background: ${xcolors.soft-black};
          border-bottom: 1px solid ${xcolors.light-black};
          color: ${xcolors.white};
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
          color: ${xcolors.white};
        }

        #entry {
          border-radius: 4px;
          padding: 4px;
        }

        #entry:selected {
          background: ${xcolors.light-black};
        }
      '';
    };
  };
}
