{ lib, lib2, ... }:
with lib;
{
  options.profi.workloads = mkOption {
    type = with types; listOf (enum lib2.workloads);
  };

  imports = [
    ./system-purity
    ./cross-compilation.nix
    ./partitions.nix
  ];
}
