{ lib, lib2, ... }:
with lib;
{
  options.profi.workloads = mkOption {
    type = lib2.workloadType;
  };

  imports = [
    ./desktop

    ./android.nix
  ];
}
