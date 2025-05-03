{
  pkgs,
  lib2,
  config,
  ...
}:
{
  home.packages =
    with pkgs;
    lib2.mkIfWorkload config "desktop" [
      firefox-wayland
      libreoffice
      kate
      vlc
    ];

  xdg.mimeApps.defaultApplications = lib2.mkIfWorkload config "desktop" {
    "text/plain" = "org.kde.kwrite.desktop";
  };
}
