{ ... }:
{
  imports = [
    ./partitions.nix
    ./systemd.nix
    ./tty.nix
    ./vpn.nix
  ];
}
