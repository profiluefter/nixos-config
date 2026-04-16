{ self, ... }:
{
  flake.nixosModules.plasma =
    { ... }:
    {
      imports = [
        self.nixosModules.desktop-common
      ];

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
    };
}
