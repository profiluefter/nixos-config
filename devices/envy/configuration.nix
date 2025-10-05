{ ... }:
{
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix
    ./nvidia.nix

    # System modules
    ../../system-modules/desktop.nix
    ../../system-modules/cross-compilation.nix
    ../../system-modules/steam.nix
    ../../system-modules/virtualbox.nix
    ../../services/docker.nix
  ];
}
