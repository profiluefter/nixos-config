#!/usr/bin/env bash
# fs-diff.sh
set -euo pipefail

MOUNTPOINT=$(mktemp -d -t fs-diff-mountpoint-XXXXXXXXXXXXXXX)

sudo mount -o subvol=/ /dev/disk/by-uuid/72afc3e6-956b-4ba7-94eb-e7d645f5bf08 "$MOUNTPOINT"

OLD_TRANSID=$(sudo btrfs subvolume find-new "$MOUNTPOINT/root-blank" 9999999)
OLD_TRANSID=${OLD_TRANSID#transid marker was }

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
