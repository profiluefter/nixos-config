{ inputs, self, ... }:
{
  perSystem =
    {
      pkgs,
      system,
      ...
    }:
    {
      apps.nixos-testbench-vm =
        let
          startScript = pkgs.writeShellScript "run-nixos-testbench-vm" ''
            export NIX_DISK_IMAGE=$(${pkgs.coreutils}/bin/mktemp --suffix -nixos-testbench-disk.img)
            rm "$NIX_DISK_IMAGE" # will be recreated by script
            trap 'echo "Deleting disk image $NIX_DISK_IMAGE" && rm "$NIX_DISK_IMAGE"' EXIT
            echo "Starting NixOS testbench VM with disk image: $NIX_DISK_IMAGE"
            ${self.nixosConfigurations.nixos-testbench.config.system.build.vm}/bin/run-nixos-testbench-vm
          '';
        in
        {
          type = "app";
          program = "${startScript}";
        };

      apps.framework-install =
        let
          installScript = pkgs.writeShellScript "do-framework-install" ''
            set -eux
            if [ ! -b ${self.nixosConfigurations.framework.config.disko.devices.disk.ssd.device} ]; then
                echo "Target SSD not found at ${self.nixosConfigurations.framework.config.disko.devices.disk.ssd.device}! Aborting installation."
                exit 1
            fi
            read -p "This will install the framework configuration to the internal NVMe SSD. Continue? (y/N) " -r answer
            if [[ ! $answer =~ ^[Yy]$ ]]; then
                echo "Installation aborted."
                exit 1
            fi

            # TODO: Secrets provisioning, see https://github.com/nix-community/disko/blob/83c4da299c1d7d300f8c6fd3a72ac46cb0d59aae/tests/disko-install/default.nix#L60
            ${
              inputs.disko.packages.${system}.disko-install
            }/bin/disko-install --flake ${self}#framework --write-efi-boot-entries
          '';
        in
        {
          type = "app";
          program = "${installScript}";
        };
    };
}
