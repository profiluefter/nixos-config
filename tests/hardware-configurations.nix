import ./make-test.nix ({ pkgs, ... }:
{
  name = "hardware-configurations";

  meta = with pkgs.stdenv.lib.maintainers; {
    maintainers = [ fabian ];
  };

  nodes = {
    fabian-ws = { config, pkgs, ... }: {
      imports = [ ./devices/fabian-ws/hardware-configuration.nix ];
    };

    envy = { config, pkgs, ... }: {
      imports = [ ./devices/envy/hardware-configuration.nix ];
    };

    nixos-testbench = { config, pkgs, ... }: {
      imports = [ ./devices/nixos-testbench/hardware-configuration.nix ];
    };
  };

  testScript = ''
    # Test fabian-ws hardware configuration
    $fabian-ws->start;
    $fabian-ws->waitForUnit("multi-user.target");
    $fabian-ws->succeed("ls /dev/disk/by-uuid/72afc3e6-956b-4ba7-94eb-e7d645f5bf08");

    # Test envy hardware configuration
    $envy->start;
    $envy->waitForUnit("multi-user.target");
    $envy->succeed("ls /dev/disk/by-partlabel/disk-ssd-btrfs");

    # Test nixos-testbench hardware configuration
    $nixos-testbench->start;
    $nixos-testbench->waitForUnit("multi-user.target");
    $nixos-testbench->succeed("ls /dev/disk/by-uuid/cd4ab2f9-8013-4b08-b6bb-db3ce2a4d0f5");
  '';
})
