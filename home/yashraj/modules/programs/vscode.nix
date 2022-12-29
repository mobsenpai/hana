{
  inputs,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;

    extensions = with pkgs.vscode-extensions; [
      esbenp.prettier-vscode
      christian-kohler.path-intellisense
      bbenoist.nix
      jdinhlife.gruvbox
      file-icons.file-icons
      kamadorueda.alejandra
    ];

    userSettings = {
      # "editor.fontWeight" = "bold";
      "editor.tabSize" = 2;
      "editor.letterSpacing" = 1.05;
      "editor.lineHeight" = 20;
      "problems.showCurrentInStatus" = true;
      "editor.multiCursorModifier" = "ctrlCmd";
      "editor.scrollbar.horizontal" = "hidden";
      "prettier.singleQuote" = true;
      "telemetry.telemetryLevel" = "off";
      "[css]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[html]"."editor.defaultFormatter" = "vscode.html-language-features";
      "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[jsonc]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "workbench.colorTheme" = "Gruvbox Dark Hard";
      "workbench.iconTheme" = "file-icons";
      "editor.cursorStyle" = "block";
      "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
      # "editor.fontSize" = 13;
      "editor.fontLigatures" = true;
      "workbench.fontAliasing" = "antialiased";
      "files.trimTrailingWhitespace" = true;
      # "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
      # "window.titleBarStyle" = "custom";
      "terminal.integrated.automationShell.linux" = "nix-shell";
      "terminal.integrated.defaultProfile.linux" = "zsh";
      "terminal.integrated.cursorBlinking" = true;
      "terminal.integrated.enableBell" = false;
      "editor.formatOnPaste" = true;
      "editor.formatOnSave" = true;
      "editor.formatOnType" = false;
      "editor.minimap.enabled" = false;
      "editor.minimap.renderCharacters" = false;
      "editor.overviewRulerBorder" = false;
      "editor.renderLineHighlight" = "all";
      "editor.inlineSuggest.enabled" = true;
      "editor.smoothScrolling" = true;
      "editor.suggestSelection" = "first";
      "editor.guides.indentation" = true;
      "editor.guides.bracketPairs" = true;
      "editor.bracketPairColorization.enabled" = true;
      "window.nativeTabs" = true;
      "window.restoreWindows" = "all";
      "window.menuBarVisibility" = "toggle";
      "workbench.panel.defaultLocation" = "right";
      "workbench.editor.tabCloseButton" = "left";
      "workbench.startupEditor" = "none";
      "workbench.list.smoothScrolling" = true;
      "security.workspace.trust.enabled" = false;
      "explorer.confirmDelete" = false;
      "breadcrumbs.enabled" = true;
    };
  };
}
