{ pkgs, lib2, config, ... }:
{
  home.packages = lib2.mkIfWorkload config "desktop" [ pkgs.libinput ];

  programs.plasma = {
    configFile."kcminputrc" = lib2.mkIfWorkload config "hardware-envy" {
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
