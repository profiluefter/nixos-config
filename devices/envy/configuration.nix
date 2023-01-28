{ lib, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./touchpad.nix
  ];

    # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.systemd-boot.extraEntries."arch.conf" = ''
    title   Arch btw
    linux   /vmlinuz-linux-zen
    initrd  /intel-ucode.img
    initrd  /initramfs-linux-zen.img
    options root="LABEL=linux" rootflags="subvol=arch-os" rw quiet splash log_level=3 udev.log_level=3
  '';

  networking.hostName = "envy"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  services.xserver.videoDrivers = [ "nvidia" ];
  #hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.prime = {
    offload.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    kate
    (pkgs.writeShellScriptBin "nvidia-offload" ''
      export __NV_PRIME_RENDER_OFFLOAD=1
      export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export __VK_LAYER_NV_optimus=NVIDIA_only
      exec "$@"
    '')
  ];
}
