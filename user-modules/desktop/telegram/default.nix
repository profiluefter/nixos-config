{ pkgs, stdenv, ... }:
{
  home.packages = [
    pkgs.tdesktop
    (pkgs.callPackage ./autostart.nix {})
  ];
}