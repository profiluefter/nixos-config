{ ... }:
{
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix

    ./amdgpu.nix
    ./soundcard.nix
    ./g910.nix
    #./screens.nix

    ../../system-modules/virtualbox.nix
    ../../services/docker.nix
  ];
}
