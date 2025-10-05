{ pkgs, ... }:
{
  home.packages = [
    pkgs.kdePackages.yakuake
    (pkgs.makeAutostartItem {
      name = "yakuake";
      srcPrefix = "org.kde.";
      package = pkgs.kdePackages.yakuake;
    })
  ];

  programs.plasma.configFile."yakuakerc" = {
    "Dialogs"."FirstRun" = false;
    "Window"."KeepOpen" = false;
  };

  programs.plasma.configFile."konsolerc" = {
    "Desktop Entry"."DefaultProfile" = "NixOS Profile.profile";
  };

  home.file.".local/share/konsole/NixOS Profile.profile" = {
    text = ''
      [General]
      Name=NixOS Profile
      Parent=FALLBACK/

      [Scrolling]
      HistorySize=10000
    '';
  };
}
