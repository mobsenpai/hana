{
  config,
  lib,
  ...
}: {
  options = {
    myhome.helix.enable = lib.mkEnableOption "Enables helix";
  };

  config = lib.mkIf config.myhome.helix.enable {
    xdg.mimeApps.defaultApplications."text/plain" = "Helix.desktop";

    programs.helix = {
      enable = true;

      languages = {
      language-server.emmet-ls = {
        command = "emmet-ls";
        args = ["--stdio"];
      }; 

      language = [
        {
          name = "html";
          file-types = ["html" "htm"];
          auto-format = true;
          formatter = {
            command = "prettier";
            args = ["--parser" "html"];
          };
          language-servers = ["vscode-html-language-server" "emmet-ls"];
        }
        {
          name = "json";
          auto-format = true;
          formatter = {
            command = "prettier";
            args = ["--parser" "json"];
          };
        }
        {
          name = "css";
          file-types = ["css"];
          auto-format = true;
          formatter = {
            command = "prettier";
            args = ["--parser" "css"];
          };
          language-servers = ["vscode-css-language-server" "emmet-ls"];
        }
        {
          name = "javascript";
          file-types = ["js" "jsx" "ts" "tsx"];
          auto-format = true;
          formatter = {
            command = "prettier";
            args = ["--parser" "typescript"];
          };
          language-servers = ["typescript-language-server" "emmet-ls"];
        }
        {
          name = "nix";
          auto-format = true;
          formatter.command = "alejandra";
          language-servers = ["nil"];
        }
      ];
      };

      settings = {
        theme = "base16_transparent";

        editor = {
          line-number = "relative";
          completion-trigger-len = 1;
          bufferline = "multiple";
          color-modes = true;
          statusline = {
            left = [
              "mode"
              "spacer"
              "diagnostics"
              "version-control"
              "file-name"
              "read-only-indicator"
              "file-modification-indicator"
              "spinner"
            ];
            right = [
              "file-encoding"
              "file-type"
              "selections"
              "position"
            ];
          };
          cursor-shape.insert = "bar";
          whitespace.render.tab = "all";
          indent-guides = {
            render = true;
            character = "┊";
          };
        };
      };
    };
  };
}
