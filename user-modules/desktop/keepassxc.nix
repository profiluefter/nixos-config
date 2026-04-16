{ pkgs, ... }:
let
  keepassxc-autostart = pkgs.makeAutostartItem {
    name = "KeePassXC";
    srcPrefix = "org.keepassxc.";
    package = pkgs.keepassxc;
  };
in
{
  home.packages = [
    keepassxc-autostart
    pkgs.keepassxc
  ];
}
