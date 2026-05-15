{ ... }:
{
  flake.nixosModules.default =
    { ... }:
    {
      systemd.settings.Manager.DefaultTimeoutStopSec = "10s";
    };
}
