{ pkgs, ... }:
{
  home.packages = with pkgs; [
    xournalpp
    virt-viewer
    kmymoney
  ];
}
