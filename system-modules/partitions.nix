{ lib, config, ... }:
with lib;
let
  cfg = config.profi.partitions;
  createPartition = subvolume: neededForBoot: {
    device = cfg.btrfsDevice;
    fsType = "btrfs";
    options = [
      "subvol=${cfg.subvolPrefix}${subvolume}"
      "compress=zstd"
      "noatime"
    ];
    inherit neededForBoot;
  };
in
{
  options.profi.partitions = {
    enable = mkEnableOption "partition setup";
    btrfsDevice = mkOption { type = types.str; };
    subvolPrefix = mkOption {
      type = types.str;
      default = "";
    };
    bootDevice = mkOption { type = types.str; };
  };

  config = mkIf cfg.enable {
    fileSystems."/" = createPartition "root" true;
    fileSystems."/nix" = createPartition "nix" false;
    fileSystems."/data" = createPartition "data" true;
    fileSystems."/persist" = createPartition "persist" true;
    fileSystems."/var/log" = createPartition "log" true;
    fileSystems."/boot" = {
      device = cfg.bootDevice;
      fsType = "vfat";
    };
  };
}
