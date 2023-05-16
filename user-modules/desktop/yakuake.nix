{ pkgs, ... }:
{
  home.packages = [
    pkgs.libsForQt5.yakuake
    (pkgs.makeAutostartItem {
      name = "yakuake";
      srcPrefix = "org.kde.";
      package = pkgs.libsForQt5.yakuake;
    })
  ];

  programs.plasma.files."yakuakerc"."Dialogs"."FirstRun" = false;
}
