{
  pkgs,
  themes,
  ...
}: {
  programs.waybar = let
    inherit (themes.colorscheme) xcolors;
  in {
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
          format = "<span background='${xcolors.brightblue}' foreground='${xcolors.darkbg}'> 󱑆 </span><span background='${xcolors.blue}' foreground='#ffffff'> {:%a %b %d - %I:%M %p} </span>";
          format-alt = "<span background='${xcolors.brightblue}' foreground='${xcolors.darkbg}'> 󱑆 </span><span background='${xcolors.blue}' foreground='#ffffff'> {:%H:%M} </span>";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        cpu = {
          format = "<span background='${xcolors.brightyellow}' foreground='${xcolors.darkbg}'>  </span><span background='${xcolors.lightbg2}' foreground='${xcolors.yellow}'> {usage}% </span>";
        };

        "custom/playerctl" = {
          exec = "${pkgs.playerctl}/bin/playerctl -a metadata --format '{\"text\": \"{{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
          format = "{icon}<span background='${xcolors.lightbg2}' foreground='${xcolors.magenta}'> {} </span>";
          format-icons = {
            "Paused" = "<span background='${xcolors.brightmagenta}' foreground='${xcolors.darkbg}'> 󰎈 </span>";
            "Playing" = "<span background='${xcolors.brightmagenta}' foreground='${xcolors.darkbg}'>  </span>";
          };
          max-length = 20;
          on-click = "${pkgs.playerctl}/bin/playerctl play-pause";
          on-click-middle = "${pkgs.playerctl}/bin/playerctl previous";
          on-click-right = "${pkgs.playerctl}/bin/playerctl next";
          return-type = "json";
        };

        "custom/weather" = {
          exec = "${pkgs.wttrbar}/bin/wttrbar --location Bihar --hide-conditions";
          format = "<span background='${xcolors.brightgreen}' foreground='${xcolors.darkbg}'>  </span><span background='${xcolors.lightbg2}' foreground='${xcolors.green}'> {}° </span>";
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
          format = "<span background='${xcolors.brightcyan}' foreground='${xcolors.darkbg}'> 󰍛 </span><span background='${xcolors.cyan}' foreground='${xcolors.lightbg2}'> {}% </span>";
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
        font-family: 'monospace';
        font-size: 10pt;
        font-weight: bold;
      }

      tooltip {
        background: ${xcolors.black};
        border: 1px solid ${xcolors.lightbg2};
        border-radius: 8px;
        color: ${xcolors.white};
      }

      tooltip label {
        margin: 2px;
      }

      /* Waybar window */
      window#waybar {
        background: ${xcolors.black};
        color: ${xcolors.white};
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
        background: ${xcolors.lightbg2};
        padding: 0px 2px 0px 0px;
        margin: 2px 0px 2px 2px;
      }

      /* Workspaces */
      #workspaces {
        background: ${xcolors.black};
        color: ${xcolors.white};
      }

      #workspaces button {
        background: ${xcolors.black};
        color: ${xcolors.white};
        min-width: 20px;
      }

      #workspaces button.active {
        background: ${xcolors.brightorange};
        color: ${xcolors.darkbg};
      }

      #workspaces button.urgent {
        background: ${xcolors.brightred};
        color: #ffffff;
      }

      /* Window */
      #window {
        color: ${xcolors.green};
        font-weight: normal;
      }

      /* Systray */
      menu {
        background: ${xcolors.black};
        border: 1px solid ${xcolors.lightbg2};
        border-radius: 8px;
        color: ${xcolors.white};
      }

      menu separator {
        background: ${xcolors.lightbg2};
      }

      menu menuitem {
        background: transparent;
        padding: 8px;
      }

      menu menuitem:hover {
        background: ${xcolors.brightorange};
        color: ${xcolors.darkbg};
      }

      menu menuitem:first-child {
        border-radius: 8px 8px 0 0;
      }

      menu menuitem:last-child {
        border-radius: 0 0 8px 8px;
      }

      menu menuitem:only-child {
        border-radius: 8px;
      }
    '';
  };
}
