{ pkgs, lib2, config, ... }:
{
  home.packages = lib2.mkIfWorkload config "desktop" [
    pkgs.tdesktop
    (pkgs.callPackage ./autostart.nix {})
  ];
}
