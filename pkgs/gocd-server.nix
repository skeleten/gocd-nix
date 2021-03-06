{ system, pkgs, lib, stdenv, ...}:
stdenv.mkDerivation rec {
  pname = "gocd-server";
  version = "21.3.0-13067";

  src = builtins.fetchurl {
    url = "https://download.go.cd/binaries/${version}/generic/go-server-${version}.zip";
    sha256 = "0gzmdvg0jxhhvgzqy6n8ycnni5wr7w8wwxsfig21sis97ifmcwkb";
  };

  meta = with lib; {
    description = "A continuos delivery server specializing in advanced workflow modeling and visualization";
    homepage = "https://www.go.cd";
    license = licenses.asl20;
    platforms = platforms.all;
  };

  nativeBuildInputs = [ pkgs.unzip ];

  buildCommand =
    let
      versionParts = lib.splitString "-" version;
      baseVersion = lib.lists.elemAt versionParts 0;
    in
      ''
      unzip $src -d $out
      mv $out/go-server-${baseVersion} $out/go-server
      mkdir -p $out/go-server/conf
      '';
}
