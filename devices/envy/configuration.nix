{ lib, pkgs, ... }:
{
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix
    ./nvidia.nix
    ./touchpad.nix
  ];
}
