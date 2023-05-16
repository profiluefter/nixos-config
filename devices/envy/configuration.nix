{ lib, pkgs, ... }:
{
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix
    ./nvidia.nix
  ];

  profi.workloads = [
    "android"
    "desktop"
    "school"
    "hardware-envy"
  ];
}
