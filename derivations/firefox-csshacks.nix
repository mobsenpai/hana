{
  lib,
  stdenv,
  src,
}:
stdenv.mkDerivation {
  pname = "firefox-csshacks";
  version = "dev";

  inherit src;

  dontConfigure = true;
  dontBuild = true;
  doCheck = false;

  installPhase = ''
    mkdir -p $out/share/firefox-csshacks
    cp -r $src/* $out/share/firefox-csshacks
  '';

  meta = with lib; {
    description = "Custom css for firefox";
    homepage = "https://github.com/MrOtherGuy/firefox-csshacks";
    license = licenses.unlicense;
  };
}
