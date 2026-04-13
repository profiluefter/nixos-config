{ ... }:
{
  flake.modules.nixos.workstation =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.cifs-utils ];
    };
}
