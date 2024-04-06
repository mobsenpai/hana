{
  config,
  pkgs,
  ...
}: {
  xdg.mimeApps.defaultApplications."text/plain" = "";

  programs.helix = {
    enable = true;

    languages.language = [
      {
        name = "html";
      }
      {
        name = "css";
      }
      {
        name = "javascript";
      }
      {
        name = "nix";
      }
    ];

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
}
