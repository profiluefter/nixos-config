{ lib, host, ... }:
lib.mkIf(host == "nixos-testbench")
{
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix
    ./network.nix
  ];
}
