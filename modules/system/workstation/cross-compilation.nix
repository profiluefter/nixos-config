{ ... }:
{
  flake.modules.nixos.workstation =
    { ... }:
    {
      boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
    };
}
