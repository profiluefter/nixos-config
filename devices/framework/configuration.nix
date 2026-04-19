{ inputs, ... }:
{
  imports = [
    ./bootloader.nix
    ./drives.nix

    inputs.nixos-hardware.nixosModules.framework-13th-gen-intel
  ];

  fileSystems."/data".neededForBoot = true;
  fileSystems."/persist".neededForBoot = true;
  fileSystems."/var/log".neededForBoot = true;

  disko = {
    enableConfig = true;
    checkScripts = true;
  };
}
