{
  lib,
  stdenv,
  fetchzip,
  ...
}:
stdenv.mkDerivation rec {
  pname = "gruvbox-plus-icon-pack";
  version = "4.0";

  src = fetchzip {
    url = "https://github.com/SylEleuth/${pname}/releases/download/v${version}/${pname}-${version}.zip";
    sha256 = "sha256-EiAu3SFhMXTI6raCuyIdOtoe0g4Pfcsk8H+I6b2jQZw=";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/icons/Gruvbox-Plus-Dark
    cp -r * $out/share/icons/Gruvbox-Plus-Dark
    runHook postInstall
  '';

  meta = with lib; {
    description = "Gruvbox Plus icon pack for Linux desktops based on Gruvbox color theme";
    homepage = "https://github.com/SylEleuth/gruvbox-plus-icon-pack";
    license = licenses.gpl3;
  };
}
