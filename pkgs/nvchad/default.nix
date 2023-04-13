{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "nvchad";
  version = "master";

  src = fetchFromGitHub {
    repo = pname;
    owner = "NvChad";
    rev = "${version}";
    sha256 = "sha256-Bl+73nBP49V3AKFtxuqYCx0TP21abeGUzWfx/2kybds=";
  };

  dontConfigure = true;
  dontBuild = true;
  doCheck = false;

  installPhase = ''
    mkdir -p $out/share/nvchad
    cp -r $src/* $out/share/nvchad
  '';

  meta = with lib; {
    description = "Neovim config written in lua";
    homepage = "https://github.com/NvChad/NvChad";
    license = licenses.unlicense;
  };
}
