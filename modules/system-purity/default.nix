{ lib, config, ... }:
with lib;
let
  cfg = config.profi.systemPurity;
in
{
  imports = [
    ../partitions.nix

    ./rollback.nix
    ./persistence.nix
  ];

  options.profi.systemPurity = {
    enable = mkEnableOption "system purity";
    rollback = mkEnableOption "restores the system root to an empty snapshot on boot";
  };
}
