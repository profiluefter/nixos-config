{ lib, lib2, ... }:
with lib;
{
  options.profi.workloads = mkOption {
    type = lib2.workloadType;
  };

  imports = [
    ./desktop
    ./hardware
    ./vim

    ./android.nix
    ./coding-tools.nix
    ./gpg.nix
    ./latex.nix
    ./nix-index.nix
    ./nixpkgs.nix
    ./school.nix
    ./shell.nix
  ];
}
