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

    ./impermanence/rollback.nix
    ./impermanence/defaults.nix
    ./impermanence/persistence.nix
    ./impermanence/utils.nix
  ];
}
