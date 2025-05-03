{
  pkgs,
  lib2,
  config,
  ...
}:
let
  enabled = lib2.hasWorkload config "desktop";
in
{
  # Enable the X11 windowing system.
  services.xserver.enable = enabled;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = enabled;
  services.desktopManager.plasma6.enable = enabled;

  # use wayland per default
  services.displayManager.defaultSession = "plasma";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "at";
    variant = "nodeadkeys";
  };

  fonts.packages =
    with pkgs;
    lib2.mkIfWorkload config "desktop" [
      corefonts
      noto-fonts
      noto-fonts-emoji
      liberation_ttf
      jetbrains-mono
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      vistafonts
    ];
}
