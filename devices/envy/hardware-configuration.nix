{ config, lib, pkgs, modulesPath, ... }:
{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/4dfdf851-9acb-42d4-b45b-de50bee04755";
      fsType = "btrfs";
      options = [ "subvol=nix-os/root" "compress=zstd" "noatime" ];
    };
  
  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/4dfdf851-9acb-42d4-b45b-de50bee04755";
      fsType = "btrfs";
      options = [ "subvol=nix-os/nix" "compress=zstd" "noatime" ];
    };
  
  fileSystems."/data" =
    { device = "/dev/disk/by-uuid/4dfdf851-9acb-42d4-b45b-de50bee04755";
      fsType = "btrfs";
      options = [ "subvol=nix-os/data" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };
  
  fileSystems."/persist" =
    { device = "/dev/disk/by-uuid/4dfdf851-9acb-42d4-b45b-de50bee04755";
      fsType = "btrfs";
      options = [ "subvol=nix-os/persist" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };
  
  fileSystems."/var/log" =
    { device = "/dev/disk/by-uuid/4dfdf851-9acb-42d4-b45b-de50bee04755";
      fsType = "btrfs";
      options = [ "subvol=nix-os/log" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/EC6A-D41C";
      fsType = "vfat";
    };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp5s0.useDHCP = lib.mkDefault true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
