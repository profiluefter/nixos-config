{ pkgs, ... }:
{
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-curses;
    sshKeys = [ "F14AB18A69F3A862C4AB47DAF3C49AFC6A443015" ];
  };
}
