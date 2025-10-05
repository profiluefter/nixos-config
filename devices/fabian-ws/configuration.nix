{ ... }:
{
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix

    ./amdgpu.nix
    ./soundcard.nix
    ./g910.nix
    #./screens.nix

    # System modules
    ../../system-modules/desktop.nix
    ../../system-modules/cross-compilation.nix
    ../../system-modules/steam.nix
    ../../system-modules/virtualbox.nix
    ../../services/docker.nix
  ];
}
