{ lib, config, ... }:
with lib;
let
  workloads = [
    "school"
    "android"
    "desktop"
    "hardware-envy"
  ];
in
{
  inherit workloads;

  workloadType = with types; listOf (enum workloads);

  mkIfWorkload = workload: content:
    assert builtins.elem workload workloads;
    /*mkIf (builtins.elem workload config.profi.workloads)*/ content;
}
