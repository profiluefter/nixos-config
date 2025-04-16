import <nixpkgs/nixos/tests/make-test.nix> ({ pkgs, ... }:
{
  name = "systemd-services";

  meta = with pkgs.stdenv.lib.maintainers; {
    maintainers = [ "profiluefter" ];
  };

  nodes = {
    machine = { config, pkgs, ... }: {
      imports = [ ./configuration.nix ];
    };
  };

  testScript = ''
    machine.start();

    # Wait for the system to reach the multi-user.target
    machine.waitForUnit("multi-user.target");

    # Check if all systemd services are correctly started and running as expected
    machine.succeed("systemctl list-units --type=service --state=running");

    # Assert that there are no failed services
    machine.succeed("systemctl --failed --no-legend");

    # Ensure that all units that are enabled start successfully
    machine.succeed("systemctl list-units --type=service --state=enabled --no-legend");
  '';
})
