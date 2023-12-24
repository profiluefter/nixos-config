{ lib, pkgs, ... }:
{
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix
    ./nvidia.nix
  ];

  profi.workloads = [
    "android"
    "coding"
    "cross-compile"
    "ctf"
    "desktop"
    "docker"
    "gaming"
    "hardware-envy"
    "latex"
    "school"
  ];
}
