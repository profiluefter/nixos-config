{ config, lib, pkgs, modulesPath, ... }:
{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  profi.systemPurity = {
    enable = true;
    rollback = true;
  };

  profi.partitions = {
    enable = true;
    btrfsDevice = "/dev/disk/by-uuid/72afc3e6-956b-4ba7-94eb-e7d645f5bf08";
    bootDevice = "/dev/disk/by-uuid/4499-08AD";
  };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/386aa628-a7a0-43ce-82da-7916838c1ec1"; }
    ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;
}
