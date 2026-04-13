{ ... }:
{
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix

    ./amdgpu.nix
    ./soundcard.nix
    ./g910.nix
    #./screens.nix

    ../../services/docker.nix
  ];
}
