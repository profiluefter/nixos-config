{ pkgs, ... }:
{
  home.packages = with pkgs; [
    firefox-wayland
    libreoffice
    kdePackages.kate
    vlc
  ];

  xdg.mimeApps.defaultApplications = {
    "text/plain" = "org.kde.kwrite.desktop";
  };
}
