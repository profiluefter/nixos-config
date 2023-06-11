{ ... }:
{
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix
    ./network.nix
  ];

  profi.workloads = [
  ];
}
