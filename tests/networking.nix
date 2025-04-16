import <nixpkgs/nixos/tests/make-test.nix> ({ pkgs, ... }:
{
  name = "networking";

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

    # Check if the networking configurations are properly applied
    machine.waitForUnit("NetworkManager");

    # Assert that the NetworkManager service is active
    machine.succeed("systemctl is-active NetworkManager");

    # Check if DHCP settings are applied
    machine.succeed("systemctl is-active dhcpcd");
  '';
})
