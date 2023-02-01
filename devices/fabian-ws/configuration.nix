{ lib, host, ... }:
{
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix

    ./network.nix
    ./nvidia.nix
    ./soundcard.nix
    ./g910.nix
    #./screens.nix
  ];
}
