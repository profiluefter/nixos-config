{ ... }:
{
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
