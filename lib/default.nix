{ lib, ... }:
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

  mkIfWorkload = config: workload: content:
    assert builtins.elem workload workloads;
    mkIf (builtins.elem workload config.profi.workloads) content;

  hasWorkload = config: workload:
    assert builtins.elem workload workloads;
    builtins.elem workload config.profi.workloads;
}
