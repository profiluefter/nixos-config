import <nixpkgs/nixos/tests/make-test.nix> ({ pkgs, ... }:
{
  name = "docker";

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

    # Check if the Docker service is enabled and functioning as expected
    machine.waitForUnit("docker");

    # Assert that the Docker service is active
    machine.succeed("systemctl is-active docker");

    # Validate Docker service functionality
    machine.succeed("docker ps");
    machine.succeed("docker run hello-world");
  '';
})
