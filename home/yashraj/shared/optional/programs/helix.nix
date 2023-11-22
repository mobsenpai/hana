{
  config,
  pkgs,
  ...
}: let
  inherit (config) colorscheme;
in {
  programs.helix = {
    enable = true;
    settings = {
      theme = colorscheme.slug;
      editor = {
        color-modes = true;
        line-number = "relative";
        indent-guides.render = true;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
    };
    themes = {
      "${colorscheme.slug}" = {
        palette = builtins.mapAttrs (name: value: "#${value}") colorscheme.colors;
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
        "diagnostic.error" = {underline = {style = "curl";};};
        "diagnostic.hint" = {underline = {style = "curl";};};
        "diagnostic.info" = {underline = {style = "curl";};};
        "diagnostic.warning" = {underline = {style = "curl";};};
        "diff.delta" = "base09";
        "diff.minus" = "base08";
        "diff.plus" = "base0B";
        "error" = "base08";
        "function" = "base0D";
        "hint" = "base03";
        "info" = "base0D";
        "keyword" = "base0E";
        "label" = "base0E";
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
        "namespace" = "base0E";
        "operator" = "base05";
        "special" = "base0D";
        "string" = "base0B";
        "type" = "base0A";
        "ui.background" = {bg = "base00";};
        "ui.bufferline" = {
          fg = "base04";
          bg = "base00";
        };
        "ui.bufferline.active" = {
          fg = "base00";
          bg = "base03";
          modifiers = ["bold"];
        };
        "ui.cursor" = {
          fg = "base04";
          modifiers = ["reversed"];
        };
        "ui.cursor.insert" = {
          fg = "base0A";
          modifiers = ["underlined"];
        };
        "ui.cursor.match" = {
          fg = "base0A";
          modifiers = ["underlined"];
        };
        "ui.cursor.select" = {
          fg = "base0A";
          modifiers = ["underlined"];
        };
        "ui.cursorline.primary" = {
          fg = "base05";
          bg = "base01";
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
          fg = "base0B";
          bg = "base02";
        };
        "ui.statusline.inactive" = {
          bg = "base01";
          fg = "base02";
        };
        "ui.statusline.insert" = {
          fg = "base00";
          bg = "base0B";
        };
        "ui.statusline.normal" = {
          fg = "base00";
          bg = "base04";
        };
        "ui.statusline.select" = {
          fg = "base00";
          bg = "base0E";
        };
        "ui.text" = "base05";
        "ui.text.focus" = "base05";
        "ui.virtual.indent-guide" = {fg = "base03";};
        "ui.virtual.ruler" = {bg = "base01";};
        "ui.virtual.whitespace" = {fg = "base01";};
        "ui.window" = {bg = "base01";};
        "variable" = "base08";
        "variable.other.member" = "base08";
        "warning" = "base09";
      };
    };
  };
}
