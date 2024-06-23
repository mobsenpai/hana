{
  lib,
  config,
  ...
}: let
  cfg = config.modules.services.gnome-keyring;
in
  lib.mkIf cfg.enable
  {
    services.gnome.gnome-keyring.enable = true;
  }
