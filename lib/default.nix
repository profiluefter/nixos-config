{ lib, config, ... }:
{
  workloads = [
    "school"
    "android"
    "desktop"
  ];

  mkIfWorkload = workload: content:
    lib.mkIf (builtins.elem workload config.profi.workloads) content;
}
