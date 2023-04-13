{
  lib,
  stdenv,
  fetchFromGitHub,
}: let
  custom = ./custom;
in
  stdenv.mkDerivation rec {
    pname = "NvChad";
    version = "2.0.0";

    src = fetchFromGitHub {
      repo = pname;
      owner = "NvChad";
      rev = "refs/heads/v2.0";
      sha256 = "sha256-7c2DmZe7olC7575syftoiF0DfmIVox9rPDgy0Qj/uV8=";
    };

    dontConfigure = true;
    dontBuild = true;
    doCheck = false;

    installPhase = ''
      mkdir $out
      cp -r * "$out/"
      mkdir -p "$out/lua/custom"
      cp -r ${custom}/* "$out/lua/custom/"
    '';

    meta = with lib; {
      description = "Neovim config written in lua";
      homepage = "https://github.com/NvChad/NvChad";
      license = licenses.gpl3;
    };
  }
