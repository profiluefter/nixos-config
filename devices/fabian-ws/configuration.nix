{ ... }:
{
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix
    ./partitions.nix

    ./amdgpu.nix
    ./soundcard.nix
    ./g910.nix
    #./screens.nix
  ];
}
