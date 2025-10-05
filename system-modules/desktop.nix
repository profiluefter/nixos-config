{ pkgs, ... }:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # use wayland per default
  services.displayManager.defaultSession = "plasma";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "at";
    variant = "nodeadkeys";
  };

  fonts.packages = with pkgs; [
    corefonts
    noto-fonts
    noto-fonts-emoji
    liberation_ttf
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    vistafonts
  ];
}
