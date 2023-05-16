{ lib, lib2, ... }:
with lib;
{
  options.profi.workloads = mkOption {
    type = lib2.workloadType;
  };

  imports = [
    ./system-purity

    ./cross-compilation.nix
    ./desktop.nix
    ./partitions.nix
    ./steam.nix
  ];
}
