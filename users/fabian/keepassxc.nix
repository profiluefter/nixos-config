{ pkgs, config, ... }:
let
  keepassxc-autostart = pkgs.makeAutostartItem { name = "KeePassXC"; srcPrefix = "org.keepassxc."; package = pkgs.keepassxc; };
in
{
  home.packages = [
    keepassxc-autostart
    pkgs.keepassxc
  ];

  # TODO: move device specific configuration
  home.file = {
    passwords.source = config.lib.file.mkOutOfStoreSymlink "/data/sync/passwords";
  };
}