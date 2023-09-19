{ config, lib, pkgs, modulesPath, ... }:
{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.supportedFilesystems = [ "ntfs" ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  profi.systemPurity = {
    enable = true;
    rollback = true;
  };

  profi.partitions = {
    enable = false;
    btrfsDevice = "/dev/disk/by-partlabel/disk-ssd-btrfs";
    subvolPrefix = "nix-os/";
    bootDevice = "/dev/disk/by-partlabel/disk-ssd-esp";
  };

  disko.devices = (import ./drives.nix { ssd-disk = "/dev/nvme0n1"; }).disko.devices;

  fileSystems."/data".neededForBoot = true;
  fileSystems."/persist".neededForBoot = true;
  fileSystems."/var/log".neededForBoot = true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
