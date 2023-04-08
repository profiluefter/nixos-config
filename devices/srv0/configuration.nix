{ config, pkgs, lib, ... }:
{
  networking.networkmanager.enable = lib.mkForce false;
}
