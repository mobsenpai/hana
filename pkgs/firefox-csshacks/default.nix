{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "firefox-csshacks";
  version = "master";

  src = fetchFromGitHub {
    repo = pname;
    owner = "MrOtherGuy";
    rev = "${version}";
    sha256 = "sha256-Bl+73nBP49V3AKFtxuqYCx0TP21abeGUzWfx/2kybds=";
  };

  dontConfigure = true;
  dontBuild = true;
  doCheck = false;

  installPhase = ''
    mkdir $out
    cp -r * "$out/"
  '';

  meta = with lib; {
    description = "Custom css for firefox";
    homepage = "https://github.com/MrOtherGuy/firefox-csshacks";
    license = licenses.unlicense;
  };
}
