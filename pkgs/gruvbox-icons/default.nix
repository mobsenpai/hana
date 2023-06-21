{
  lib,
  stdenv,
  fetchurl,
  ...
}:
stdenv.mkDerivation rec {
  pname = "gruvbox-plus-icon-pack";
  version = "master";

  src = fetchurl {
    url = "https://github.com/SylEleuth/gruvbox-plus-icon-pack/releases/download/v${version}/gruvbox-plus-icon-pack-${version}.zip";
    sha256 = "";
  };

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/icons
    cp -r ./gruvbox-icons-* $out/share/icons
    runHook postInstall
  '';

  meta = with lib; {
    description = "Open source macOS Cursors";
    homepage = "https://github.com/ful1e5/apple_cursor";
    license = licenses.gpl3;
    platforms = platforms.unix;
  };
}
