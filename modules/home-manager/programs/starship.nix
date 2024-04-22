{
  config,
  lib,
  ...
}: {
  options = {
    myhome.starship.enable = lib.mkEnableOption "Enables starship";
  };

  config = lib.mkIf config.myhome.starship.enable {
    home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        scan_timeout = 10;

        add_newline = true;
        line_break.disabled = true;

        format = "$directory$git_branch$git_metrics$git_commit$git_state$git_status$all";

        character = {
          success_symbol = "[λ](green)";
          error_symbol = "[λ](red)";
          vimcmd_symbol = "[λ](green)";
        };

        directory = {
          home_symbol = "home";
          style = "cyan";
        };

        git_commit.tag_symbol = " tag ";
        git_branch = {
          style = "purple";
          symbol = "";
        };

        git_metrics = {
          added_style = "bold yellow";
          deleted_style = "bold red";
          disabled = false;
        };

        java.symbol = "󰬷 ";
        lua.symbol = "󰢱 ";
        meson.symbol = "⬢ ";
        nix_shell.symbol = " ";
        nodejs.symbol = " ";
        package.symbol = "󰏖 ";
        php.symbol = " ";
        python.symbol = "󰌠 ";
        ruby.symbol = "󰴭 ";
        rust.symbol = "󱘗 ";
      };
    };
  };
}
