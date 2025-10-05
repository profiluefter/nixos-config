{ ... }:
{
  # This module no longer defines the profi.workloads option
  # Individual modules should be imported directly in device configurations

  imports = [
    ./system-purity

    ./cifs.nix
    ./compatibility.nix
    ./nix.nix
    ./partitions.nix
    ./systemd.nix
    ./tty.nix
    ./vpn.nix
  ];
}
