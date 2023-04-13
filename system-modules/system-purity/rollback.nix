{ lib, config, ... }:
with lib;
let
  cfg = config.profi.systemPurity;
  partCfg = config.profi.partitions;
in
{
  # Rollback
  # from https://mt-caret.github.io/blog/posts/2020-06-29-optin-state.html

  config = mkIf (cfg.enable && cfg.rollback) {
    boot.initrd.postDeviceCommands = mkBefore ''
      mkdir -p /mnt

      # We first mount the btrfs root to /mnt
      # so we can manipulate btrfs subvolumes.
      mount -o subvol=/ ${partCfg.btrfsDevice} /mnt

      # While we're tempted to just delete /root and create
      # a new snapshot from /root-blank, /root is already
      # populated at this point with a number of subvolumes,
      # which makes `btrfs subvolume delete` fail.
      # So, we remove them first.
      #
      # /root contains subvolumes:
      # - /root/var/lib/portables
      # - /root/var/lib/machines
      #
      # I suspect these are related to systemd-nspawn, but
      # since I don't use it I'm not 100% sure.
      # Anyhow, deleting these subvolumes hasn't resulted
      # in any issues so far, except for fairly
      # benign-looking errors from systemd-tmpfiles.
      btrfs subvolume list -o /mnt/${partCfg.subvolPrefix}root |
      cut -f9 -d' ' |
      while read subvolume; do
        echo "deleting /$subvolume subvolume..."
        btrfs subvolume delete "/mnt/$subvolume"
      done &&
      echo "deleting /${partCfg.subvolPrefix}root subvolume..." &&
      btrfs subvolume delete /mnt/${partCfg.subvolPrefix}root

      echo "restoring blank /${partCfg.subvolPrefix}root subvolume..."
      btrfs subvolume snapshot /mnt/${partCfg.subvolPrefix}root-blank /mnt/${partCfg.subvolPrefix}root

      # Once we're done rolling back to a blank snapshot,
      # we can unmount /mnt and continue on the boot process.
      umount /mnt
    '';
  };
}
