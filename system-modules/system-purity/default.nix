{ lib, ... }:
with lib;
{
  imports = [
    ../partitions.nix

    ./rollback.nix
    ./persistence.nix
    ./utils.nix
  ];

  options.profi.systemPurity = {
    enable = mkEnableOption "system purity";
    rollback = mkEnableOption "restores the system root to an empty snapshot on boot";
  };
}
