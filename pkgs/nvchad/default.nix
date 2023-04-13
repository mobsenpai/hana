{
  lib,
  stdenv,
  fetchFromGitHub,
}: let
  custom = ./custom;
in
  stdenv.mkDerivation rec {
    pname = "NvChad";
    version = "v2.0";

    src = fetchFromGitHub {
      repo = pname;
      owner = "NvChad";
      rev = "${version}";
      sha256 = "sha256-B7KX+o1wNGhq7cqUb6WWaocrk1/h81jl8HLI9JDlME0=";
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
