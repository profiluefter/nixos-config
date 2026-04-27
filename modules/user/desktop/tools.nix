{ ... }:
{
  flake.homeModules.desktop-common =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        xournalpp
        virt-viewer
        kmymoney
      ];
    };
}
