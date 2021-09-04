{
  description = "GoCD Server and Agent configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    let      
    in utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
          drvenv = {
            system = system;
            pkgs = pkgs;
            stdenv = pkgs.stdenv;
            lib = nixpkgs.lib;
          };          
      in
      rec {
        packages = import ./pkgs drvenv;
        defaultPackage = packages.gocd-agent;
      });
}
