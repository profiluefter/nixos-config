{ pkgs, lib2, config, ... }:
let
  enabled = lib2.hasWorkload config "desktop";
in
{
  # Enable the X11 windowing system.
  services.xserver.enable = enabled;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = enabled;
  services.xserver.desktopManager.plasma5.enable = enabled;

  # use unstable sddm to fix environment variables after login with wayland
  nixpkgs.overlays = [
    (final: prev: {
      libsForQt5 = prev.libsForQt5 // {
        sddm = final.unstable.libsForQt5.sddm;
      };
    })
  ];

  # use wayland per default
  services.xserver.displayManager.defaultSession = "plasmawayland";

  # Configure keymap in X11
  services.xserver = {
    layout = "at";
    xkbVariant = "nodeadkeys";
  };

  fonts.fonts = with pkgs; lib2.mkIfWorkload config "desktop" [
    corefonts
    noto-fonts
    noto-fonts-emoji
    liberation_ttf
    jetbrains-mono
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    vistafonts
  ];
}
