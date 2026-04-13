{ ... }:
{
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix
    ./nvidia.nix

    ../../system-modules/steam.nix
    ../../system-modules/virtualbox.nix
    ../../services/docker.nix
  ];
}
