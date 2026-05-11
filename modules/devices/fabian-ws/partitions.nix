{ ... }:
{
  flake.nixosModules.fabian-ws =
    { ... }:
    let
      btrfsDevice = "/dev/disk/by-uuid/72afc3e6-956b-4ba7-94eb-e7d645f5bf08";
      bootDevice = "/dev/disk/by-uuid/4499-08AD";
      createPartition = subvolume: neededForBoot: {
        device = btrfsDevice;
        fsType = "btrfs";
        options = [
          "subvol=${subvolume}"
          "compress=zstd"
          "noatime"
        ];
        inherit neededForBoot;
      };
    in
    {
      fileSystems."/" = createPartition "root" true;
      fileSystems."/nix" = createPartition "nix" false;
      fileSystems."/data" = createPartition "data" true;
      fileSystems."/persist" = createPartition "persist" true;
      fileSystems."/var/log" = createPartition "log" true;
      fileSystems."/boot" = {
        device = bootDevice;
        fsType = "vfat";
      };
    };
}
