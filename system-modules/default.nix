{ ... }:
{
  imports = [
    ./nix.nix
    ./partitions.nix
    ./systemd.nix
    ./tty.nix
    ./vpn.nix
  ];
}
