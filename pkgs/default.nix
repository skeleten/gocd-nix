{ system, pkgs, lib, stdenv } @ drvenv:
{
  gocd-agent = pkgs.callPackage ./gocd-agent.nix {};
  gocd-server = pkgs.callPackage ./gocd-server.nix {};
}
