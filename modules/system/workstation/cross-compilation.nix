{ ... }:
{
  flake.nixosModules.workstation =
    { ... }:
    {
      boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
    };
}
