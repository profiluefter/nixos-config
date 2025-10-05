{ pkgs, ... }:
{
  # Override the default curses pinentry with Qt pinentry for desktop
  services.gpg-agent.pinentry.package = pkgs.pinentry-qt;

  home.packages = [ pkgs.kdePackages.kleopatra ];
}
