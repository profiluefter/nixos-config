{ pkgs, ... }:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # KDE Plasma tiling extension
  environment.systemPackages = [ pkgs.libsForQt5.bismuth ];

  # use wayland per default
  services.xserver.displayManager.defaultSession = "plasmawayland";

  # Configure keymap in X11
  services.xserver = {
    layout = "at";
    xkbVariant = "nodeadkeys";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  fonts.fonts = with pkgs; [
    corefonts
    noto-fonts
    noto-fonts-emoji
    liberation_ttf
    jetbrains-mono
    vistafonts
  ];
}
