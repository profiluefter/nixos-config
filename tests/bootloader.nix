import <nixpkgs/nixos/tests/make-test.nix> ({ pkgs, ... }:
{
  name = "bootloader";

  meta = with pkgs.stdenv.lib.maintainers; {
    maintainers = [ "profiluefter" ];
  };

  nodes = {
    envy = { config, pkgs, ... }: {
      imports = [ ./devices/envy/bootloader.nix ];
    };

    fabian-ws = { config, pkgs, ... }: {
      imports = [ ./devices/fabian-ws/bootloader.nix ];
    };

    nixos-testbench = { config, pkgs, ... }: {
      imports = [ ./devices/nixos-testbench/bootloader.nix ];
    };
  };

  testScript = ''
    # Start the VMs
    envy.create;
    fabian-ws.create;
    nixos-testbench.create;

    # Boot the VMs
    envy.start;
    fabian-ws.start;
    nixos-testbench.start;

    # Check that the bootloader is correctly configured
    envy.waitForUnit("systemd-boot");
    fabian-ws.waitForUnit("systemd-boot");
    nixos-testbench.waitForUnit("grub");

    # Verify that the bootloader configurations are correctly set up
    assert envy.succeed("bootctl status");
    assert fabian-ws.succeed("bootctl status");
    assert nixos-testbench.succeed("grub-install --version");
  '';
})
