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
    enable = false;
    rollback = false;
  };

  profi.partitions = {
    enable = true;
    btrfsDevice = "/dev/disk/by-uuid/4dfdf851-9acb-42d4-b45b-de50bee04755";
    subvolPrefix = "nix-os/";
    bootDevice = "/dev/disk/by-uuid/EC6A-D41C";
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
