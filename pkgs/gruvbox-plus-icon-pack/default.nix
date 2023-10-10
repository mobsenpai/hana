{
  lib,
  stdenv,
  fetchurl,
  unzip,
  ...
}:
stdenv.mkDerivation rec {
  pname = "gruvbox-plus-icon-pack";
  version = "4.0";

  src = fetchurl {
    url = "https://github.com/SylEleuth/${pname}/releases/download/v${version}/${pname}-${version}.zip";
    sha256 = "sha256-m9bNcPfjaTcyb0XuvfQH0btqqFzPstLABPM8xHF7WBs=";
  };

  nativeBuildInputs = [unzip];

  installPhase = ''
    mkdir -p $out/share/icons
    unzip $src -d $out/share/icons
  '';

  meta = with lib; {
    description = "Gruvbox Plus icon pack for Linux desktops based on Gruvbox color theme";
    homepage = "https://github.com/SylEleuth/gruvbox-plus-icon-pack";
    license = licenses.gpl3;
  };
}
