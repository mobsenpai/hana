{
  lib,
  stdenv,
  src,
}:
stdenv.mkDerivation {
  pname = "arkenfox";
  version = "dev";

  inherit src;

  dontConfigure = true;
  dontBuild = true;
  doCheck = false;

  installPhase = ''
    mkdir -p $out/share/arkenfox
    cp -r $src/* $out/share/arkenfox
  '';

  meta = with lib; {
    description = "User.js for enhanced firefox security";
    homepage = "https://github.com/arkenfox/user.js";
    license = licenses.unlicense;
  };
}
