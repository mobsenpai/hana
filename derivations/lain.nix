{
  lib,
  stdenv,
  src,
}:
stdenv.mkDerivation {
  pname = "lain";
  version = "dev";

  inherit src;

  dontConfigure = true;
  dontBuild = true;
  doCheck = false;

  installPhase = ''
    mkdir -p $out/share/lain
    cp -r $src/* $out/share/lain
    sed 's/lain/module/g' "${pkgs.lain}/share/lain/init.lua"
  '';

  meta = with lib; {
    description = "AwesomeWM lain module";
    homepage = "https://github.com/lcpz/lain.git";
    license = licenses.unlicense;
  };
}
