{ pkgs, lib2, ... }:
{
  home.packages = [ pkgs.libinput ];

  programs.plasma = {
    files."kcminputrc" = lib2.mkIfWorkload "hardware-envy" {
      "Libinput.2.7.SynPS/2 Synaptics TouchPad" = {
        "ClickMethod" = "2";
        "NaturalScroll" = "true";
        "ScrollMethod" = "1";
        "TapToClick" = "true";
        "PointerAcceleration" = "0.200";
      };
    };
  };
}
