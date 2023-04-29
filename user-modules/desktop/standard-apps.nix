{ pkgs, ... }:
{
  home.packages = with pkgs; [
    firefox-wayland
    libreoffice
    kate
    vlc
  ];

  xdg.mimeApps.defaultApplications = {
    "text/plain" = "org.kde.kwrite.desktop";
  };
}
