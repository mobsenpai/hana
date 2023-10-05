{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "nvchad";
  version = "2.0.0";
  custom = ./custom;

  src = fetchFromGitHub {
    repo = "NvChad";
    owner = "NvChad";
    rev = "refs/heads/v2.0";
    sha256 = "sha256-ZlOOw8xjtpL72pQPKDufuY/fHIPMwDPh68xo1EDp3DY=";
  };

  installPhase = ''
    mkdir $out
    cp -r * "$out/"
    mkdir -p "$out/lua/custom"
    cp -r ${custom}/* "$out/lua/custom/"
  '';

  meta = with lib; {
    description = "Blazing fast Neovim config providing solid defaults and a beautiful UI, enhancing your neovim experience";
    homepage = "https://github.com/NvChad/NvChad";
    license = licenses.gpl3;
  };
}
