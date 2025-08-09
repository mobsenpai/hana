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
        # Language servers
        emmet-ls
        nil
        nodePackages.typescript-language-server
        nodePackages.vscode-langservers-extracted
        pyright
        clang-tools
        jdt-language-server

        # Formatters
        alejandra
        black
        nodePackages.prettier
        google-java-format
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
          {
            name = "python";
            file-types = ["py"];
            auto-format = true;
            formatter = {
              command = "black";
              args = ["--stdio"];
            };
            language-servers = ["pyright"];
          }
          {
            name = "c";
            file-types = ["c" "h"];
            auto-format = true;
            formatter.command = "clang-format";
            language-servers = ["clangd"];
          }
          {
            name = "cpp";
            file-types = ["cpp" "cc" "cxx" "hpp" "hcc" "hxx"];
            auto-format = true;
            formatter.command = "clang-format";
            language-servers = ["clangd"];
          }
          {
            name = "java";
            file-types = ["java"];
            auto-format = true;
            formatter = {
              command = "google-java-format";
              args = ["-"];
            };
            language-servers = ["jdtls"];
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
        "attributes" = "base09";
        "comment" = {
          fg = "base03";
          modifiers = ["italic"];
        };
        "constant" = "base09";
        "constant.character.escape" = "base0C";
        "constant.numeric" = "base09";
        "constructor" = "base0D";
        "debug" = "base03";
        "diagnostic" = {modifiers = ["underlined"];};
        "diff.delta" = "base09";
        "diff.minus" = "base08";
        "diff.plus" = "base0B";
        "error" = "base08";
        "function" = "base0D";
        "hint" = "base03";
        "info" = "base0D";
        "keyword" = "base0E";
        "label" = "base0E";
        "namespace" = "base0E";
        "operator" = "base05";
        "special" = "base0D";
        "string" = "base0B";
        "type" = "base0A";
        "variable" = "base08";
        "variable.other.member" = "base0B";
        "warning" = "base09";
        "markup.bold" = {
          fg = "base0A";
          modifiers = ["bold"];
        };
        "markup.heading" = "base0D";
        "markup.italic" = {
          fg = "base0E";
          modifiers = ["italic"];
        };
        "markup.link.text" = "base08";
        "markup.link.url" = {
          fg = "base09";
          modifiers = ["underlined"];
        };
        "markup.list" = "base08";
        "markup.quote" = "base0C";
        "markup.raw" = "base0B";
        "markup.strikethrough" = {modifiers = ["crossed_out"];};
        "diagnostic.hint" = {underline = {style = "curl";};};
        "diagnostic.info" = {underline = {style = "curl";};};
        "diagnostic.warning" = {underline = {style = "curl";};};
        "diagnostic.error" = {underline = {style = "curl";};};
        "ui.background" = {bg = "base00";};
        "ui.bufferline.active" = {
          fg = "base00";
          bg = "base03";
          modifiers = ["bold"];
        };
        "ui.bufferline" = {
          fg = "base04";
          bg = "base00";
        };
        "ui.cursor" = {
          fg = "base0A";
          modifiers = ["reversed"];
        };
        "ui.cursor.insert" = {
          fg = "base0A";
          modifiers = ["reversed"];
        };
        "ui.cursorline.primary" = {
          fg = "base05";
          bg = "base01";
        };
        "ui.cursor.match" = {
          fg = "base0A";
          modifiers = ["reversed"];
        };
        "ui.cursor.select" = {
          fg = "base0A";
          modifiers = ["reversed"];
        };
        "ui.gutter" = {bg = "base00";};
        "ui.help" = {
          fg = "base06";
          bg = "base01";
        };
        "ui.linenr" = {
          fg = "base03";
          bg = "base00";
        };
        "ui.linenr.selected" = {
          fg = "base04";
          bg = "base01";
          modifiers = ["bold"];
        };
        "ui.menu" = {
          fg = "base05";
          bg = "base01";
        };
        "ui.menu.scroll" = {
          fg = "base03";
          bg = "base01";
        };
        "ui.menu.selected" = {
          fg = "base01";
          bg = "base04";
        };
        "ui.popup" = {bg = "base01";};
        "ui.selection" = {bg = "base02";};
        "ui.selection.primary" = {bg = "base02";};
        "ui.statusline" = {
          fg = "base04";
          bg = "base01";
        };
        "ui.statusline.inactive" = {
          bg = "base01";
          fg = "base03";
        };
        "ui.statusline.insert" = {
          fg = "base00";
          bg = "base0B";
        };
        "ui.statusline.normal" = {
          fg = "base00";
          bg = "base03";
        };
        "ui.statusline.select" = {
          fg = "base00";
          bg = "base0F";
        };
        "ui.text" = "base05";
        "ui.text.focus" = "base05";
        "ui.virtual.indent-guide" = {fg = "base03";};
        "ui.virtual.inlay-hint" = {fg = "base03";};
        "ui.virtual.ruler" = {bg = "base01";};
        "ui.virtual.jump-label" = {
          fg = "base0A";
          modifiers = ["bold"];
        };
        "ui.window" = {bg = "base01";};

        palette = xcolors;
      };
    };

    xdg.desktopEntries.Helix = let
      helix = getExe config.programs.helix.package;
      xdg-terminal = getExe pkgs.xdg-terminal-exec;
    in {
      name = "Helix";
      genericName = "Text Editor";
      comment = "Edit text files";
      exec = "${xdg-terminal} --title=Editor --app-id=helix -e ${helix} %F";
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
