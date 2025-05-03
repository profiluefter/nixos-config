# My NixOS configuration

## TODO

- Automate adding new files and folders to the persistent storage
  - Create a script that moves the folder and adds an entry to some CSV file that is read at evaluation time?
- Move global project-specific configuration to individual nix-shell projects
  - e.g. make Android SDK only available in Android projects
- Migrate all devices to use disko partitioning
- Think of a mechanism to automatically provision a newly installed system with required SSH, syncthing, etc. keys
- Add btrfs swap file
  - Add to disko config
