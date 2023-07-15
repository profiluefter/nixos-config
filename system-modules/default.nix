{ lib, lib2, ... }:
with lib;
{
  options.profi.workloads = mkOption {
    type = lib2.workloadType;
  };

  imports = [
    ./system-purity

    ./compatibility.nix
    ./cross-compilation.nix
    ./desktop.nix
    ./nix.nix
    ./partitions.nix
    ./steam.nix
    ./systemd.nix
    ./virtualbox.nix
  ];
}
