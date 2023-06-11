{ config, pkgs, lib, ... }:
{
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix
  ];

  networking.networkmanager.enable = lib.mkForce false;

  profi.workloads = [
  ];
}
