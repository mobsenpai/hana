{
  config,
  lib,
  pkgs,
  ...
}: let
  formatIcon = bg: fg: icon: "<span background='${bg}' foreground='${fg}'> ${icon} </span>";
  formatText = bg: fg: text: "<span background='${bg}' foreground='${fg}'> ${text} </span>";
in {
  options = {
    myhome.waybar.enable = lib.mkEnableOption "Enables waybar";
  };

  config = lib.mkIf config.myhome.waybar.enable {
    programs.waybar = with config.myhome.colorscheme; {
      enable = true;
      systemd.enable = true;
      systemd.target = "graphical-session.target";

      settings = [
        {
          exclusive = true;
          fixed-center = true;
          layer = "top";
          position = "top";
          spacing = 8;

          modules-left = ["hyprland/workspaces" "hyprland/window"];
          modules-center = ["custom/playerctl"];
          modules-right = ["custom/weather" "memory" "cpu" "clock" "tray"];

          clock = {
            format = formatIcon xcolors.blue xcolors.dark-black "󱑆" + formatText xcolors.dark-blue xcolors.white "{:%a %b %d - %I:%M %p}";
            format-alt = formatIcon xcolors.blue xcolors.dark-black "󱑆" + formatText xcolors.dark-blue xcolors.white "{:%H:%M}";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          };

          cpu = {
            format = formatIcon xcolors.yellow xcolors.dark-black "" + formatText xcolors.soft-black xcolors.dark-yellow "{usage}%";
          };

          "custom/playerctl" = {
            exec = "${pkgs.playerctl}/bin/playerctl -a metadata --format '{\"text\": \"{{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
            format = formatIcon xcolors.purple xcolors.dark-black "{icon}" + formatText xcolors.soft-black xcolors.dark-purple "{}";
            format-icons = {
              "Paused" = "󰎈";
              "Playing" = "";
            };
            max-length = 20;
            on-click = "${pkgs.playerctl}/bin/playerctl play-pause";
            on-click-middle = "${pkgs.playerctl}/bin/playerctl previous";
            on-click-right = "${pkgs.playerctl}/bin/playerctl next";
            return-type = "json";
          };

          "custom/weather" = {
            exec = "${pkgs.wttrbar}/bin/wttrbar --location Bihar --hide-conditions";
            format = formatIcon xcolors.green xcolors.dark-black "" + formatText xcolors.soft-black xcolors.dark-green "{}°";
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
            format = formatIcon xcolors.aqua xcolors.dark-black "󰍛" + formatText xcolors.dark-aqua xcolors.soft-black "{}%";
          };

          tray = {
            reverse-direction = true;
            spacing = 4;
          };
        }
      ];

      style = ''
        * {
          all: unset;
          font-family: "JetBrainsMono Nerd Font";
          font-size: 10pt;
          font-weight: normal;
        }

        window#waybar {
          background: ${xcolors.black};
          color: ${xcolors.white};
        }

        .modules-left{
          padding-left: 2px;
        }

        .modules-right {
          padding-right: 2px;
        }

        #clock,
        #cpu,
        #custom-playerctl,
        #custom-weather,
        #workspaces,
        #window,
        #memory,
        #tray {
          margin-top: 2px;
          margin-bottom: 2px;
        }

        #workspaces {
          background: ${xcolors.black};
          color: ${xcolors.gray};
        }

        #workspaces button {
          background: ${xcolors.black};
          color: ${xcolors.gray};
          min-width: 20px;
        }

        #workspaces button.active {
          background: ${xcolors.orange};
          color: ${xcolors.dark-black};
        }

        #workspaces button.urgent {
          background: ${xcolors.red};
          color: ${xcolors.white};
        }

        #window {
          color: ${xcolors.dark-green};
        }

        tooltip,
        #tray menu {
          background: ${xcolors.soft-black};
          border: 1px solid ${xcolors.light-black};
          border-radius: 8px;
          color: ${xcolors.white};
        }

        #tray menu {
          padding: 4px;
        }

        #tray menu separator {
          background: ${xcolors.light-black};
        }

        #tray menu menuitem {
          border-radius: 4px;
          color: ${xcolors.white};
          padding: 4px;
        }

        #tray menu menuitem:hover {
          background: ${xcolors.light-black};
          color: ${xcolors.white};
        }
      '';
    };
  };
}
