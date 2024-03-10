{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.profi.systemPurity;
  partCfg = config.profi.partitions;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.inotify-tools
      (pkgs.writeShellScriptBin "fs-watch" "${pkgs.inotify-tools}/bin/inotifywait -m -e modify -r --excludei 'discord' $@")
      (pkgs.writeShellScriptBin "fs-diff" ''
        set -euo pipefail

        MOUNTPOINT=$(mktemp -d -t fs-diff-mountpoint-XXXXXXXXXXXXXXX)

        trap "sudo umount $MOUNTPOINT && rmdir $MOUNTPOINT" EXIT
        sudo mount -o subvol=/ ${partCfg.btrfsDevice} "$MOUNTPOINT"

        OLD_TRANSID=$(sudo btrfs subvolume find-new "$MOUNTPOINT/${partCfg.subvolPrefix}root-blank" 9999999)
        OLD_TRANSID=''${OLD_TRANSID#transid marker was }

        sudo btrfs subvolume find-new "$MOUNTPOINT/${partCfg.subvolPrefix}root" "$OLD_TRANSID" |
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
      '')
      (pkgs.writeShellScriptBin "file-diff" ''
        set -euo pipefail

        if [[ $# -ne 1 ]]; then
          echo "Usage: file-diff <file>"
          exit 1
        fi

        if [[ ! -f $1 ]]; then
          echo "The file '$1' does not exist"
          exit 1
        fi

        FILE="$1"
        FILE_CONTENT=$(cat "$FILE")

        while true; do
          ${pkgs.inotify-tools}/bin/inotifywait -e modify --quiet "$FILE"
          ${pkgs.delta}/bin/delta <(echo "$FILE_CONTENT") "$FILE" || true
        done
      '')
    ];
  };
}
