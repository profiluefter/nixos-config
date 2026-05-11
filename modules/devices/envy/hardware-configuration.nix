{ ... }:
{
  flake.nixosModules.envy =
    {
      config,
      lib,
      modulesPath,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot.supportedFilesystems = [ "ntfs" ];

      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-intel" ];
      boot.extraModulePackages = [ ];

      fileSystems."/data".neededForBoot = true;
      fileSystems."/persist".neededForBoot = true;
      fileSystems."/var/log".neededForBoot = true;

      services.thermald.enable = true;

      powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
