{ ... }:
{
  flake.nixosModules.default =
    { pkgs, ... }:
    {
      # List packages installed in system profile. To search, run:
      # $ nix search wget
      environment.systemPackages = with pkgs; [
        file
        htop
        micro
        vim
        wget
        killall
      ];
    };
}
