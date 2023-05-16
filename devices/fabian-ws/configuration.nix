{ lib, host, ... }:
{
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix

    ./nvidia.nix
    ./soundcard.nix
    ./g910.nix
    #./screens.nix
  ];

  profi.workloads = [
    "android"
    "desktop"
    "school"
    "coding"
    "latex"
    "gaming"
  ];
}
