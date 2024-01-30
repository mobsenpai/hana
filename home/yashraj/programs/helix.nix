{
  config,
  pkgs,
  ...
}: {
  # xdg.mimeApps.defaultApplications."text/plain" = "";

  programs.helix = {
    enable = true;
  };
}
