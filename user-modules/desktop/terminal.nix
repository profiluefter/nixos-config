{
  pkgs,
  lib2,
  config,
  ...
}:
{
  home.packages = lib2.mkIfWorkload config "desktop" [
    pkgs.libsForQt5.yakuake
    (pkgs.makeAutostartItem {
      name = "yakuake";
      srcPrefix = "org.kde.";
      package = pkgs.libsForQt5.yakuake;
    })
  ];

  programs.plasma.configFile."yakuakerc" = lib2.mkIfWorkload config "desktop" {
    "Dialogs"."FirstRun" = false;
    "Window"."KeepOpen" = false;
  };

  programs.plasma.configFile."konsolerc" = lib2.mkIfWorkload config "desktop" {
    "Desktop Entry"."DefaultProfile" = "NixOS Profile.profile";
  };

  home.file.".local/share/konsole/NixOS Profile.profile" = lib2.mkIfWorkload config "desktop" {
    text = ''
      [General]
      Name=NixOS Profile
      Parent=FALLBACK/

      [Scrolling]
      HistorySize=10000
    '';
  };
}
