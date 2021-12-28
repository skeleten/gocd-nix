{
  description = "GoCD Server and Agent configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    let customPkgs = callPackage: {
          gocd-agent = callPackage ./pkgs/gocd-agent.nix {};
          gocd-server = callPackage ./pkgs/gocd-server.nix {};
        };
    in
    utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};          
      in {
        packages = utils.lib.flattenTree (customPkgs pkgs.callPackage);
      }) // {
        overlay = (final: prev: customPkgs final.callPackage);
        nixosModules =
          {
            gocd-agent = ./modules/gocd-agent.nix;
          };
      };
}
