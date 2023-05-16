{ pkgs, config, lib2, ... }:
let
  keepassxc-autostart = pkgs.makeAutostartItem { name = "KeePassXC"; srcPrefix = "org.keepassxc."; package = pkgs.keepassxc; };
in
{
  home.packages = lib2.mkIfWorkload config "desktop" [
    keepassxc-autostart
    pkgs.keepassxc
  ];

  # TODO: move device specific configuration
  home.file = lib2.mkIfWorkload config "desktop" {
    passwords.source = config.lib.file.mkOutOfStoreSymlink "/data/sync/passwords";
  };
}
