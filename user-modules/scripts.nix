{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "delay-diff" ''
      set -euo pipefail

      # Usage: delay-diff <file>
      # Creates a diff of the file changes that happen while waiting for the user
      # to press enter.

      if [ $# -ne 1 ]; then
        echo "Usage: delay-diff <file>"
        exit 1
      fi

      FILE_CONTENTS="$(cat "$1")"

      echo "Press enter to continue..."
      read -r

      delta <(echo "$FILE_CONTENTS") "$1" || true
    '')
  ];
}
