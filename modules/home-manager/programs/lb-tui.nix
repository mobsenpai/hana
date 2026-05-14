{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  cfg = config.modules.programs.lb-tui;
in
  lib.mkIf cfg.enable {
    home.packages = [
      inputs.lb-tui.packages.${pkgs.system}.default
    ];
  }
