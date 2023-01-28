# TODO: combine device specific partition configuration to single module with config parameters
{ lib, config, ... }:
with lib;
let
  cfg = config.profi.partitions;
#  createPartition = path: subvol-name: {
#    fileSystems
#  };
in
{
  options.profi.partitions = {
    enable = mkEnableOption "partition setup";
    btrfsDevice = mkOption { type = types.str; };
    bootDevice = mkOption { type = types.str; };
  };

  config = mkIf cfg.enable {
    fileSystems."/" = {};
  };
}
