{ lib, lib2, ... }:
with lib;
{
  options.profi.workloads = mkOption {
    type = lib2.workloadType;
  };

  imports = [
    ./desktop
    ./hardware

    ./android.nix
    ./coding-tools.nix
    ./gpg.nix
    ./latex.nix
    ./nixpkgs.nix
    ./school.nix
    ./shell.nix
  ];
}
