{ ... }:
{
  flake = {
    # TODO: check/validate disko configuration
    diskoConfigurations.envy = import ../devices/envy/drives.nix;
    diskoConfigurations.framework = import ../devices/framework/drives.nix;
  };
}
