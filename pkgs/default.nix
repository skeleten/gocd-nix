{ system, pkgs, lib, stdenv } @ drvenv:
{
  gocd-agent = import ./gocd-agent.nix drvenv;
  gocd-server = import ./gocd-server.nix drvenv;
}
