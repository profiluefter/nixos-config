{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.profi.systemPurity;
  btrfsDevice = config.profi.partitions.btrfsDevice;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.inotify-tools
      (pkgs.writeShellScriptBin "fs-watch" "inotifywait -m -e modify -r $@")
      (pkgs.writeShellScriptBin "fs-diff" ''
        set -euo pipefail

        MOUNTPOINT=$(mktemp -d -t fs-diff-mountpoint-XXXXXXXXXXXXXXX)

        sudo mount -o subvol=/ ${btrfsDevice} "$MOUNTPOINT"

        OLD_TRANSID=$(sudo btrfs subvolume find-new "$MOUNTPOINT/root-blank" 9999999)
        OLD_TRANSID=''${OLD_TRANSID#transid marker was }

        sudo btrfs subvolume find-new "$MOUNTPOINT/root" "$OLD_TRANSID" |
        sed '$d' |
        cut -f17- -d' ' |
        sort |
        uniq |
        while read path; do
          path="/$path"
          if [ -L "$path" ]; then
            : # The path is a symbolic link, so is probably handled by NixOS already
          elif [ -d "$path" ]; then
            : # The path is a directory, ignore
          else
            echo "$path"
          fi
        done

        sudo umount $MOUNTPOINT
        rmdir $MOUNTPOINT
      '')
    ];
  };
}
