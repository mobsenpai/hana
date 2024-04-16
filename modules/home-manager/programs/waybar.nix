{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    myhome.waybar.enable = lib.mkEnableOption "enables waybar";
  };

  config = lib.mkIf config.myhome.waybar.enable {
    programs.waybar = with config.myhome.colorscheme.xcolors; {
      enable = true;
      systemd.enable = true;
      systemd.target = "graphical-session.target";

      settings = [
        {
          layer = "top";
          position = "top";
          exclusive = true;
          fixed-center = true;
          spacing = 10;
          margin-top = 0;
          margin-bottom = 0;
          margin-left = 0;
          margin-right = 0;
          modules-left = ["hyprland/workspaces" "hyprland/window"];
          modules-center = ["custom/playerctl"];
          modules-right = ["custom/weather" "memory" "cpu" "clock" "tray"];

          clock = {
            format = "<span background='${brightblue}' foreground='${darkbg}'> 󱑆 </span><span background='${blue}' foreground='#ffffff'> {:%a %b %d - %I:%M %p} </span>";
            format-alt = "<span background='${brightblue}' foreground='${darkbg}'> 󱑆 </span><span background='${blue}' foreground='#ffffff'> {:%H:%M} </span>";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          };

          cpu = {
            format = "<span background='${brightyellow}' foreground='${darkbg}'>  </span><span background='${lightbg2}' foreground='${yellow}'> {usage}% </span>";
          };

          "custom/playerctl" = {
            exec = "${pkgs.playerctl}/bin/playerctl -a metadata --format '{\"text\": \"{{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
            format = "{icon}<span background='${lightbg2}' foreground='${magenta}'> {} </span>";
            format-icons = {
              "Paused" = "<span background='${brightmagenta}' foreground='${darkbg}'> 󰎈 </span>";
              "Playing" = "<span background='${brightmagenta}' foreground='${darkbg}'>  </span>";
            };
            max-length = 20;
            on-click = "${pkgs.playerctl}/bin/playerctl play-pause";
            on-click-middle = "${pkgs.playerctl}/bin/playerctl previous";
            on-click-right = "${pkgs.playerctl}/bin/playerctl next";
            return-type = "json";
          };

          "custom/weather" = {
            exec = "${pkgs.wttrbar}/bin/wttrbar --location Bihar --hide-conditions";
            format = "<span background='${brightgreen}' foreground='${darkbg}'>  </span><span background='${lightbg2}' foreground='${green}'> {}° </span>";
            tooltip = true;
            interval = 3600;
            return-type = "json";
          };

          "hyprland/workspaces" = {
            format = "{name}";
            on-click = "activate";
            disable-scroll = true;
          };

          "hyprland/window" = {
            format = "{title}";
            max-length = 40;
            seperate-outputs = true;
          };

          memory = {
            format = "<span background='${brightcyan}' foreground='${darkbg}'> 󰍛 </span><span background='${cyan}' foreground='${lightbg2}'> {}% </span>";
          };

          tray = {
            reverse-direction = true;
            spacing = 6;
          };
        }
      ];

      style = ''
        * {
          all: unset;
          font-family: "JetBrainsMono Nerd Font";
          font-size: 10pt;
          font-weight: bold;
        }

        tooltip {
          background: ${black};
          border: 1px solid ${lightbg2};
          border-radius: 8px;
          color: ${white};
        }

        tooltip label {
          margin: 2px;
        }

        /* Waybar window */
        window#waybar {
          background: ${black};
          color: ${white};
        }

        /* Left Modules */
        .modules-left {
          padding-left: 2px;
        }

        /* Right Modules */
        .modules-right {
          padding-right: 2px;
        }

        /* Modules */
        #clock,
        #cpu,
        #custom-playerctl,
        #custom-weather,
        #workspaces,
        #window,
        #memory,
        #tray {
          margin: 2px;
        }

        #custom-playerctl {
          background: ${lightbg2};
          padding-right: 2px;
        }

        /* Workspaces */
        #workspaces {
          background: ${black};
          color: ${white};
        }

        #workspaces button {
          background: ${black};
          color: ${white};
          min-width: 20px;
        }

        #workspaces button.active {
          background: ${brightorange};
          color: ${darkbg};
        }

        #workspaces button.urgent {
          background: ${brightred};
          color: #ffffff;
        }

        /* Window */
        #window {
          color: ${green};
          font-weight: normal;
        }

        /* Systray */
        menu {
          background: ${lightbg};
          border: 1px solid ${darkbg};
          border-radius: 8px;
          color: ${white};
        }

        menu separator {
          background: ${darkbg};
        }

        menu menuitem {
          background: transparent;
          padding: 4px;
          margin: 4px;
        }

        menu menuitem:hover {
          background: ${lightbg2};
          border-radius: 8px;
          color: ${white};
        }
      '';
    };
  };
}
