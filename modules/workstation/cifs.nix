{ ... }:
{
  flake.modules.nixos.workstation-utils =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.cifs-utils ];
    };
}
