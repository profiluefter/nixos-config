{ inputs, ... }:
{
  imports = [
    ./bootloader.nix

    inputs.nixos-hardware.nixosModules.framework-13th-gen-intel
  ];

  inherit (import ./drives.nix { ssd-disk = "/dev/nvme0n1"; }) disko;

  fileSystems."/data".neededForBoot = true;
  fileSystems."/persist".neededForBoot = true;
  fileSystems."/var/log".neededForBoot = true;

  profi.systemPurity = {
    enable = true;
    rollback = false;
  };

  # TODO: deprecate/remove or merge this with disko configuration
  profi.partitions = {
    enable = false;
    btrfsDevice = "/dev/disk/by-partlabel/disk-ssd-btrfs";
    subvolPrefix = "nix-os/";
    bootDevice = "/dev/disk/by-partlabel/disk-ssd-esp";
  };

  profi.workloads = [
    "android"
    "coding"
    "cross-compile"
    "ctf"
    "desktop"
    "docker"
    "gaming"
    "latex"
    "school"
  ];
}
