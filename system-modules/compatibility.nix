{ inputs, system, ... }:
{
  programs.nix-ld.enable = true;

  environment.systemPackages = [
    inputs.nix-alien.packages.${system}.nix-alien
  ];
}
