{ system, pkgs, lib, stdenv, ... }:
stdenv.mkDerivation rec {
  pname = "gocd-agent";
  version = "21.3.0-13067";  

  src = builtins.fetchurl {
    url = "https://download.go.cd/binaries/${version}/generic/go-agent-${version}.zip";
    sha256 = "1hyi23gxxz00yd5ifzz7hp90jpfwhy0nnb2b4a2fj6ylhlkw78i9";   
  };

  meta = with lib; {
    description = "A continuous delivery server specializing in advanced workflow modeling and visualization";
    homepage = "http://www.go.cd";
    license = licenses.asl20;
    platforms = platforms.all;
    #maintainers = with maintainers; [ grahamc swarren83 ];
  };

  nativeBuildInputs = [ pkgs.unzip ];

  buildCommand =
    let
      versionParts = lib.splitString "-" version;
      baseVersion = lib.lists.elemAt versionParts 0;
    in
    ''
      unzip $src -d $out
      mv $out/go-agent-${baseVersion} $out/go-agent
    '';
}
