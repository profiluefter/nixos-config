import <nixpkgs/nixos/tests/make-test.nix> ({ pkgs, ... }:
{
  name = "syncthing";

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

    # Check if the Syncthing service is correctly started and running
    machine.waitForUnit("syncthing");

    # Assert that the Syncthing service is active
    machine.succeed("systemctl is-active syncthing");
  '';
})
