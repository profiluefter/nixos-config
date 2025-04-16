import <nixpkgs/nixos/tests/make-test.nix> ({ pkgs, ... }:
{
  name = "openssh";

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

    # Check if the OpenSSH service is enabled and configured correctly
    machine.waitForUnit("sshd");

    # Assert that the OpenSSH service is active
    machine.succeed("systemctl is-active sshd");

    # Validate OpenSSH service configuration
    machine.succeed("sshd -T | grep -q 'PermitRootLogin prohibit-password'");
    machine.succeed("sshd -T | grep -q 'PasswordAuthentication no'");
  '';
})
