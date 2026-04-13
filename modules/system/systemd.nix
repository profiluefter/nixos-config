{ ... }:
{
  flake.modules.nixos.default =
    { pkgs, ... }:
    {
      systemd.extraConfig = ''
        DefaultTimeoutStopSec=10s
      '';

      services.udev.packages = [
        pkgs.android-udev-rules
      ];

      users.groups.adbusers = { }; # TODO: move to adb specific config
    };
}
