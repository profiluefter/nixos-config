{ ... }:
{
  # Enable networking
  networking.networkmanager.enable = true;

  networking.hostName = "nixos-testbench";

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
}
