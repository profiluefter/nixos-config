{ config, ... }:
{
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };

  fileSystems."/boot/firmware" = {
    device = "/dev/disk/by-label/${config.sdImage.firmwarePartitionName or "FIRMWARE"}";
    options = ["nofail" "noauto"];
  };
}
