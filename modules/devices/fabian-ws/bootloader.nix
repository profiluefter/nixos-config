{ ... }:
{
  flake.nixosModules.fabian-ws =
    { ... }:
    {
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      boot.supportedFilesystems = [ "btrfs" ];

      hardware.enableAllFirmware = true;
    };
}
