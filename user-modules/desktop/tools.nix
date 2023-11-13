{ pkgs, config, lib2, ... }:
{
  home.packages = with pkgs; lib2.mkIfWorkload config "desktop" [
    xournalpp
    virt-viewer
    kmymoney
  ];
}
