{ pkgs, lib2, config, ... }:
{
  home.packages = lib2.mkIfWorkload config "desktop" [
    pkgs.libsForQt5.yakuake
    (pkgs.makeAutostartItem {
      name = "yakuake";
      srcPrefix = "org.kde.";
      package = pkgs.libsForQt5.yakuake;
    })
  ];

  programs.plasma.files."yakuakerc"."Dialogs"."FirstRun" =
    lib2.mkIfWorkload config "desktop" false;
}
