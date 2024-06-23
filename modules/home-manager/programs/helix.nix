{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf getExe;
  inherit (config.modules.colorScheme) xcolors;
  cfg = config.modules.programs.helix;
in
  mkIf cfg.enable
  {
    programs.helix = {
      enable = true;
      defaultEditor = true;

      extraPackages = with pkgs; [
        # Runtime dependencies
        emmet-ls
        nodejs

        # Language servers
        nil
        nodePackages.typescript-language-server
        nodePackages.vscode-langservers-extracted

        # Formatters
        alejandra
        nodePackages.prettier

        # NOTE: These 'extra' lsp and formatters should be installed on a
        # per-project basis using nix shell
      ];

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
        theme = "main";

        editor = {
          bufferline = "always";
          color-modes = true;
          completion-trigger-len = 1;
          cursorline = true;
          line-number = "relative";
          rulers = [80];

          cursor-shape = {
            insert = "bar";
          };

          soft-wrap = {
            enable = true;
          };

          whitespace = {
            characters = {
              space = " ";
              nbsp = "⍽";
              nnbsp = "␣";
              tab = "→";
              newline = "¬";
              tabpad = "·";
            };

            render = {
              space = "all";
              tab = "all";
              newline = "all";
            };
          };

          indent-guides = {
            render = true;
            character = "┊";
            skip-levels = 1;
          };

          statusline = {
            left = [
              "mode"
              "file-name"
              "version-control"
              "read-only-indicator"
              "file-modification-indicator"
            ];
            right = [
              "spinner"
              "diagnostics"
              "file-type"
              "file-encoding"
              "selections"
              "position"
            ];
            mode.normal = "NORMAL";
            mode.insert = "INSERT";
            mode.select = "SELECT";
          };
        };
      };

      themes.main = {
        "attribute" = "aqua1";
        "keyword" = {fg = "red1";};
        "keyword.directive" = "red0";
        "namespace" = "aqua1";
        "punctuation" = "orange1";
        "punctuation.delimiter" = "orange1";
        "operator" = "purple1";
        "special" = "purple0";
        "variable.other.member" = "blue1";
        "variable" = "fg1";
        "variable.builtin" = "orange1";
        "variable.parameter" = "fg2";
        "type" = "yellow1";
        "type.builtin" = "yellow1";
        "constructor" = {
          fg = "purple1";
          modifiers = ["bold"];
        };
        "function" = {
          fg = "green1";
          modifiers = ["bold"];
        };
        "function.macro" = "aqua1";
        "function.builtin" = "yellow1";
        "tag" = "red1";
        "comment" = {
          fg = "gray1";
          modifiers = ["italic"];
        };
        "constant" = {fg = "purple1";};
        "constant.builtin" = {
          fg = "purple1";
          modifiers = ["bold"];
        };
        "string" = "green1";
        "constant.numeric" = "purple1";
        "constant.character.escape" = {
          fg = "fg2";
          modifiers = ["bold"];
        };
        "label" = "aqua1";
        "module" = "aqua1";

        "diff.plus" = "green1";
        "diff.delta" = "orange1";
        "diff.minus" = "red1";

        "warning" = "yellow1";
        "error" = "red1";
        "info" = "aqua1";
        "hint" = "blue1";

        "ui.background" = {bg = "bg0";};
        "ui.linenr" = {fg = "bg4";};
        "ui.linenr.selected" = {fg = "yellow1";};
        "ui.cursorline" = {bg = "bg1";};
        "ui.statusline" = {
          fg = "fg1";
          bg = "bg2";
        };
        "ui.statusline.normal" = {
          fg = "bg0";
          bg = "gray1";
        };
        "ui.statusline.insert" = {
          fg = "bg0";
          bg = "blue0";
        };
        "ui.statusline.select" = {
          fg = "fg1";
          bg = "orange0";
        };
        "ui.statusline.inactive" = {
          fg = "gray1";
          bg = "bg1";
        };
        "ui.bufferline" = {
          fg = "fg1";
          bg = "bg1";
        };
        "ui.bufferline.active" = {
          fg = "bg0";
          bg = "gray1";
        };
        "ui.bufferline.background" = {bg = "bg2";};
        "ui.popup" = {bg = "bg1";};
        "ui.window" = {bg = "bg1";};
        "ui.help" = {
          bg = "bg1";
          fg = "fg1";
        };
        "ui.text" = {fg = "fg1";};
        "ui.text.focus" = {fg = "fg1";};
        "ui.selection" = {bg = "bg2";};
        "ui.selection.primary" = {bg = "bg3";};
        "ui.cursor.primary" = {
          bg = "fg4";
          fg = "bg1";
        };
        "ui.cursor.match" = {bg = "bg3";};
        "ui.menu" = {
          fg = "fg1";
          bg = "bg2";
        };
        "ui.menu.selected" = {
          fg = "bg2";
          bg = "blue1";
          modifiers = ["bold"];
        };
        "ui.virtual.whitespace" = "bg2";
        "ui.virtual.ruler" = {bg = "bg1";};
        "ui.virtual.inlay-hint" = {fg = "gray1";};
        "ui.virtual.wrap" = {fg = "bg2";};
        "ui.virtual.jump-label" = {
          fg = "purple0";
          modifiers = ["bold"];
        };

        "diagnostic.warning" = {
          underline = {
            color = "yellow1";
            style = "curl";
          };
        };
        "diagnostic.error" = {
          underline = {
            color = "red1";
            style = "curl";
          };
        };
        "diagnostic.info" = {
          underline = {
            color = "aqua1";
            style = "curl";
          };
        };
        "diagnostic.hint" = {
          underline = {
            color = "blue1";
            style = "curl";
          };
        };
        "diagnostic.unnecessary" = {modifiers = ["dim"];};
        "diagnostic.deprecated" = {modifiers = ["crossed_out"];};

        "markup.heading" = "aqua1";
        "markup.bold" = {modifiers = ["bold"];};
        "markup.italic" = {modifiers = ["italic"];};
        "markup.strikethrough" = {modifiers = ["crossed_out"];};
        "markup.link.url" = {
          fg = "green1";
          modifiers = ["underlined"];
        };
        "markup.link.text" = "red1";
        "markup.raw" = "red1";

        palette = xcolors;
      };
    };

    xdg.desktopEntries.Helix = let
      helix = getExe config.programs.helix.package;
      terminal = config.modules.desktop.terminal.exePath;
    in {
      name = "Helix";
      genericName = "Text Editor";
      comment = "Edit text files";
      exec = "${terminal} --title editor -e ${helix} %F";
      icon = "helix";
      mimeType = [
        "text/english"
        "text/plain"
        "text/x-makefile"
        "text/x-c++hdr"
        "text/x-c++src"
        "text/x-chdr"
        "text/x-csrc"
        "text/x-java"
        "text/x-moc"
        "text/x-pascal"
        "text/x-tcl"
        "text/x-tex"
        "application/x-shellscript"
        "text/x-c"
        "text/x-c++"
      ];
      terminal = false;
      type = "Application";
      categories = [
        "Utility"
        "TextEditor"
      ];
    };

    xdg.mimeApps.defaultApplications = {
      "text/plain" = ["Helix.desktop"];
    };
  }
