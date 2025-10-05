# Refactoring Documentation: Removal of profi.workloads

## Summary

This refactoring removed the indirect "profi.workloads" feature and replaced it with direct module imports in device configurations. This makes the configuration more explicit and easier to understand.

## What Changed

### Before

The configuration used a `profi.workloads` option to indirectly enable modules:

```nix
# In device config
profi.workloads = ["desktop" "coding" "android"];

# Modules would check this list
home.packages = lib2.mkIfWorkload config "desktop" [ ... ];
```

### After

Device configurations now explicitly import the modules they need:

```nix
# In device config
imports = [
  ../../system-modules/desktop.nix
  ../../services/docker.nix
];

# In device home.nix
imports = [
  ../../user-modules/desktop
  ../../user-modules/coding-tools.nix
];
```

## New Structure

### Device Configurations

Each device now has two configuration files:

1. **configuration.nix** - System-level NixOS configuration
   - Imports system modules (desktop, docker, virtualbox, etc.)
   - Device-specific hardware configuration
   
2. **home.nix** - User-level Home Manager configuration
   - Imports user modules (desktop apps, coding tools, etc.)
   - Automatically loaded based on hostname

### Module Organization

**User Modules** (`user-modules/`):
- `common.nix` - Always imported (shell, vim, scripts, etc.)
- `gpg.nix` - GPG config with desktop pinentry (for desktop systems)
- `gpg-minimal.nix` - GPG config with curses pinentry (for servers)
- Feature modules: `android.nix`, `coding-tools.nix`, `latex.nix`, `school.nix`, `ctf/`
- Desktop module group: `desktop/` (plasma, discord, telegram, etc.)
- Hardware modules: `hardware/` (touchpad, touchpad-envy)

**System Modules** (`system-modules/`):
- `default.nix` - Common system modules always imported
- Feature modules: `desktop.nix`, `steam.nix`, `virtualbox.nix`, `cross-compilation.nix`
- Services: `services/docker.nix`

### Home Manager Integration

The `users/home-manager.nix` now dynamically imports device-specific configuration:

```nix
imports = [
  ../user-modules/common.nix
  (../devices/${config.networking.hostName}/home.nix)
  ./fabian/code.nix
];
```

## Migration Guide

### For New Devices

1. Create `devices/<device-name>/configuration.nix`:
   ```nix
   { ... }: {
     imports = [
       ./hardware-configuration.nix
       # Add system modules as needed
       ../../system-modules/desktop.nix
       ../../services/docker.nix
     ];
   }
   ```

2. Create `devices/<device-name>/home.nix`:
   ```nix
   { ... }: {
     imports = [
       # Add user modules as needed
       ../../user-modules/desktop
       ../../user-modules/coding-tools.nix
       ../../user-modules/gpg.nix
     ];
   }
   ```

### For Minimal/Server Configurations

For servers or minimal configurations:
- Only import essential system modules
- Use `gpg-minimal.nix` instead of `gpg.nix`
- Create a minimal `home.nix` with just `common.nix`

Example (nixos-testbench):
```nix
# home.nix
{ ... }: {
  # Minimal - only common modules
}
```

## Benefits

1. **Explicit Dependencies**: Each device clearly shows what features it uses
2. **Easier to Understand**: No hidden conditional logic based on workload lists
3. **Better IDE Support**: Direct imports are easier for tools to analyze
4. **Reduced Complexity**: Removed ~100 lines of indirect conditional code
5. **More Flexible**: Easy to add device-specific variations (e.g., touchpad-envy.nix)

## Files Removed/Simplified

- `lib/default.nix` - Workload helper functions removed
- `user-modules/default.nix` - No longer defines profi.workloads option
- `system-modules/default.nix` - No longer defines profi.workloads option
- All module files - Removed conditional workload checks

## Files Added

- `user-modules/common.nix` - Common baseline modules
- `user-modules/gpg-minimal.nix` - Server-friendly GPG config
- `user-modules/hardware/touchpad-envy.nix` - Device-specific touchpad config
- `devices/*/home.nix` - Per-device home-manager configurations (4 files)
