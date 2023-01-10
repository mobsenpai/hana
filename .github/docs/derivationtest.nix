{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  # util-linux,
}:
stdenvNoCC.mkDerivation {
  pname = "lain";
  version = "master";

  src = fetchFromGitHub {
    owner = "lcpz";
    repo = "lain";
    rev = "HEAD";
    sha256 = "sha256-TnsPk9UxiWHIYJ/nr7hnjcPmpIjigPR9PLEPzR4Z8Ww=";
    sparseCheckout = ["lain"];
  };

  # nativeBuildInputs = [util-linux];

  installPhase = ''
    sed 's/lain/module/g' init.lua
    mkdir -p $out/share/lain
    cp -r * $out/share/lain
    sed -i 's/lain/module/g' $out/share/lain/init.lua
  '';

  meta = with lib; {
    description = "Material Symbols icons by Google";
    homepage = "https://fonts.google.com/icons";
  };
}
# if use src then dont give src in derivations.nix

