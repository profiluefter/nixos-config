{ ... }:
{
  flake.nixosModules.workstation =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.cifs-utils ];
    };
}
