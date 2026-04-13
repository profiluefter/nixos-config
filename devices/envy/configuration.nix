{ ... }:
{
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix
    ./nvidia.nix

    ../../services/docker.nix
  ];
}
