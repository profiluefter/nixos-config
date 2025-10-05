{ pkgs, lib, ... }:
{
  # Override the default curses pinentry with Qt pinentry for desktop
  services.gpg-agent.pinentry.package = lib.mkForce pkgs.pinentry-qt;

  home.packages = [ pkgs.kdePackages.kleopatra ];
}
