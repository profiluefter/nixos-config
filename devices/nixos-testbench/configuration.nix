{ ... }:
{
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix
    ./network.nix
  ];

  profi.workloads = [
  ];
  
  users.users.test = {
    isNormalUser = true;
    description = "Test user for nixos-testbench";
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "test";
  };
}
