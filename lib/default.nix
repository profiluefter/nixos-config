{ lib, ... }:
with lib;
let
  workloads = [
    "school"
    "android"
    "desktop"
    "coding"
    "latex"
    "gaming"

    "hardware-envy"
  ];
in
rec {
  inherit workloads;

  workloadType = with types; listOf (enum workloads);

  mkIfWorkload = config: workload: content:
    mkIf (hasWorkload config workload) content;

  hasWorkload = config: workload:
    if
      builtins.isList workload
    then
      builtins.all (x: hasWorkload config x) workload
    else
      assert builtins.elem workload workloads;
      builtins.elem workload config.profi.workloads;
}
