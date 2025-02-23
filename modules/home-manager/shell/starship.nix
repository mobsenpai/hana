{
  lib,
  config,
  ...
}: let
  cfg = config.modules.shell;
in
  lib.mkIf cfg.enable
  {
    programs.starship = {
      enable = true;

      settings = {
        add_newline = false;
        format = "\\[ $username$directory$git_branch$git_metrics$git_commit$git_state$git_status$all\\]\n$character";

        character.format = "\\$ ";

        directory.style = "green";

        git_branch = {
          style = "bright-black";
          format = "[$symbol$branch(:$remote_branch)]($style) ";
        };

        git_metrics = {
          added_style = "bright-black";
          deleted_style = "bright-black";
          disabled = false;
        };

        git_status = {
          style = "bright-black";
        };

        line_break.disabled = true;

        username = {
          style_user = "green";
          show_always = true;
        };

        aws.symbol = "  ";
        buf.symbol = " ";
        c.symbol = " ";
        conda.symbol = " ";
        crystal.symbol = " ";
        dart.symbol = " ";
        directory.read_only = " 󰌾";
        docker_context.symbol = " ";
        elixir.symbol = " ";
        elm.symbol = " ";
        fennel.symbol = " ";
        fossil_branch.symbol = " ";
        git_branch.symbol = " ";
        git_commit.tag_symbol = " ";
        golang.symbol = " ";
        guix_shell.symbol = " ";
        haskell.symbol = " ";
        haxe.symbol = " ";
        hg_branch.symbol = " ";
        hostname.ssh_symbol = " ";
        java.symbol = " ";
        julia.symbol = " ";
        kotlin.symbol = " ";
        lua.symbol = " ";
        memory_usage.symbol = "󰍛 ";
        meson.symbol = "󰔷 ";
        nim.symbol = "󰆥 ";
        nix_shell.symbol = " ";
        nodejs.symbol = " ";
        ocaml.symbol = " ";
        os.symbols.NixOS = " ";
        package.symbol = "󰏗 ";
        perl.symbol = " ";
        php.symbol = " ";
        pijul_channel.symbol = " ";
        python.symbol = " ";
        rlang.symbol = "󰟔 ";
        ruby.symbol = " ";
        rust.symbol = "󱘗 ";
        scala.symbol = " ";
        swift.symbol = " ";
        zig.symbol = " ";
        gradle.symbol = " ";
      };
    };
  }
