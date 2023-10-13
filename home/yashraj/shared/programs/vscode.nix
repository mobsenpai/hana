{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  inherit (config) colorscheme;
  marketplace-extensions = with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
    visualstudioexptteam.vscodeintellicode
    johnnymorganz.stylua
    # TODO: this extension does not work when installed from here
    # golf1052.base16-generator
  ];
in {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    mutableExtensionsDir = true;
    extensions = with pkgs.vscode-extensions;
      [
        esbenp.prettier-vscode
        christian-kohler.path-intellisense
        bbenoist.nix
        jdinhlife.gruvbox
        file-icons.file-icons
        kamadorueda.alejandra
        sumneko.lua
      ]
      ++ marketplace-extensions;

    userSettings = {
      security.workspace.trust.enabled = false;
      telemetry.telemetryLevel = "off";
      prettier.singleQuote = true;
      stylua.styluaPath = lib.getExe pkgs.stylua;
      nix.serverPath = lib.getExe pkgs.nil;

      "[css]".editor.defaultFormatter = "esbenp.prettier-vscode";
      "[html]".editor.defaultFormatter = "vscode.html-language-features";
      "[javascript]".editor.defaultFormatter = "esbenp.prettier-vscode";
      "[json]".editor.defaultFormatter = "esbenp.prettier-vscode";
      "[jsonc]".editor.defaultFormatter = "esbenp.prettier-vscode";
      "[lua]".editor.defaultFormatter = "johnnymorganz.stylua";
      "[nix]".editor.defaultFormatter = "kamadorueda.alejandra";

      editor = {
        cursorBlinking = "smooth";
        cursorStyle = "block";
        cursorSmoothCaretAnimation = "on";
        cursorWidth = 2;
        editor.lineHeight = 20;
        fontLigatures = true;
        find.addExtraSpaceOnTop = false;
        fontFamily = "'monospace', monospace";
        formatOnSave = true;
        inlayHints.enabled = "off";
        inlineSuggest.enabled = true;
        letterSpacing = 1.05;
        largeFileOptimizations = false;
        lineNumbers = "on";
        linkedEditing = true;
        minimap.enabled = false;
        minimap.renderCharacters = false;
        overviewRulerBorder = false;
        quickSuggestions.strings = true;
        renderWhitespace = "none";
        renderLineHighlight = "all";
        smoothScrolling = true;
        suggest.showStatusBar = true;
        scrollbar.horizontal = "hidden";
        suggestSelection = "first";
        tabSize = 2;

        bracketPairColorization = {
          enabled = true;
          independentColorPoolPerBracketType = true;
        };

        codeActionsOnSave.source = {
          organizeImports = true;
        };

        guides = {
          bracketPairs = true;
          indentation = true;
        };
      };

      explorer = {
        confirmDragAndDrop = false;
        confirmDelete = true;
      };

      files = {
        eol = "\n";
        insertFinalNewline = true;
        trimTrailingWhitespace = true;
      };

      git = {
        autofetch = true;
        confirmSync = false;
        enableSmartCommit = true;
      };

      terminal.integrated = {
        cursorBlinking = true;
        cursorStyle = "block";
        cursorWidth = 2;
        fontFamily = "'monospace', monospace";
        smoothScrolling = true;
      };

      window = {
        menuBarVisibility = "toggle";
        nativeTabs = true;
      };

      base16.generator.activatedThemes = [
        "base16-${colorscheme.slug}"
      ];

      workbench = {
        colorTheme = "Base16 ${colorscheme.name}";
        editor.tabCloseButton = "left";
        fontAliasing = "antialiased";
        iconTheme = "file-icons";
        list.smoothScrolling = true;
        panel.defaultLocation = "right";
        smoothScrolling = true;
      };
    };
  };
}
