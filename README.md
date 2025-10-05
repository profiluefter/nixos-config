# My NixOS configuration

## Structure

This NixOS configuration uses a modular approach where each device explicitly imports the modules it needs.

- `devices/` - Per-device configurations
  - Each device has `configuration.nix` (NixOS system config) and `home.nix` (Home Manager config)
- `user-modules/` - Home Manager modules for user-level configuration
  - `common.nix` - Always imported (shell, vim, etc.)
  - Feature modules: `android.nix`, `coding-tools.nix`, `latex.nix`, etc.
  - `desktop/` - Desktop environment and applications
- `system-modules/` - NixOS system modules
  - Core modules always imported via `default.nix`
  - Optional modules: `desktop.nix`, `steam.nix`, `virtualbox.nix`, etc.
- `services/` - Service configurations (docker, networking, etc.)

See [REFACTORING.md](REFACTORING.md) for details on the recent refactoring.

## TODO

- Automate adding new files and folders to the persistent storage
  - Create a script that moves the folder and adds an entry to some CSV file that is read at evaluation time?
- Move global project-specific configuration to individual nix-shell projects
  - e.g. make Android SDK only available in Android projects
- Migrate all devices to use disko partitioning
- Think of a mechanism to automatically provision a newly installed system with required SSH, syncthing, etc. keys
- Add btrfs swap file
  - Add to disko config
- Upgrade/migrate disko config
  - Add run command to setup system (disko + nixos-install) in one go
- Add way to provision secret decryption keys automatically
