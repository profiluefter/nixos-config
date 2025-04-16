import <nixpkgs/nixos/tests/make-test.nix> ({ pkgs, ... }:
{
  name = "nixos-configurations";

  meta = with pkgs.stdenv.lib.maintainers; {
    maintainers = [ "profiluefter" ];
  };

  nodes = {
    fabian-ws = { config, pkgs, ... }: {
      imports = [ ./devices/fabian-ws/configuration.nix ];
    };

    envy = { config, pkgs, ... }: {
      imports = [ ./devices/envy/configuration.nix ];
    };

    nixos-testbench = { config, pkgs, ... }: {
      imports = [ ./devices/nixos-testbench/configuration.nix ];
    };
  };

  testScript = ''
    # Start the VMs
    fabian-ws.create;
    envy.create;
    nixos-testbench.create;

    # Boot the VMs
    fabian-ws.start;
    envy.start;
    nixos-testbench.start;

    # Check that the NixOS configurations are correctly applied
    assert fabian-ws.succeed("hostnamectl | grep -q 'fabian-ws'");
    assert envy.succeed("hostnamectl | grep -q 'envy'");
    assert nixos-testbench.succeed("hostnamectl | grep -q 'nixos-testbench'");
  '';
})
