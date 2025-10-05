{ inputs, ... }:
{
  imports = [
    ./bootloader.nix
    ./drives.nix

    inputs.nixos-hardware.nixosModules.framework-13th-gen-intel

    # System modules
    ../../system-modules/desktop.nix
    ../../system-modules/cross-compilation.nix
    ../../system-modules/steam.nix
    ../../system-modules/virtualbox.nix
    ../../services/docker.nix
  ];

  fileSystems."/data".neededForBoot = true;
  fileSystems."/persist".neededForBoot = true;
  fileSystems."/var/log".neededForBoot = true;

  profi.systemPurity = {
    enable = true;
    rollback = false;
  };

  disko = {
    enableConfig = true;
    checkScripts = true;
  };

  # TODO: deprecate/remove or merge this with disko configuration
  profi.partitions = {
    enable = false;
    btrfsDevice = "/dev/disk/by-partlabel/disk-ssd-btrfs";
    subvolPrefix = "nix-os/";
    bootDevice = "/dev/disk/by-partlabel/disk-ssd-esp";
  };
}
