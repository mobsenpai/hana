{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.programs.obsidian;
in
  lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      obsidian
    ];
  }
