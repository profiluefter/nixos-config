{ inputs, self, ... }:
{
  systems = [
    "x86_64-linux"
    "aarch64-linux"
  ];

  perSystem =
    {
      config,
      pkgs,
      system,
      ...
    }:
    let
      treefmtEval = inputs.treefmt-nix.lib.evalModule pkgs ./treefmt.nix;

    in
    {
      checks.formatting = treefmtEval.config.build.check self;
      formatter = treefmtEval.config.build.wrapper;

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

  flake =
    let
      makeNixOSConfiguration =
        hostname: system: additionalConfig:
        let
          nixpkgsConfig = {
            inherit system;
            config.allowUnfree = true;
            config.android_sdk.accept_license = true;
          };
          overlay-unstable = _final: _prev: {
            unstable = import inputs.nixpkgs-unstable nixpkgsConfig;
          };
        in
        {
          inherit system;

          specialArgs = {
            inherit system inputs;
          };

          modules = [
            # overlay for pkgs.unstable
            { nixpkgs.overlays = [ overlay-unstable ]; }
            { system.configurationRevision = self.rev or "dirty"; }

            inputs.sops-nix.nixosModules.sops
            inputs.peerix.nixosModules.peerix
            inputs.impermanence.nixosModule
            inputs.home-manager.nixosModules.home-manager
            inputs.disko.nixosModules.disko

            { networking.hostName = hostname; }

            # General configuration
            ./configuration.nix
          ]
          ++ additionalConfig;
        };
      makeNixOS =
        hostname: system: additionalConfig:
        inputs.nixpkgs.lib.nixosSystem (makeNixOSConfiguration hostname system additionalConfig);
    in
    {
      nixosConfigurations.fabian-ws = makeNixOS "fabian-ws" "x86_64-linux" [
        ./devices/fabian-ws/configuration.nix
      ];
      nixosConfigurations.envy = makeNixOS "envy" "x86_64-linux" [ ./devices/envy/configuration.nix ];
      nixosConfigurations.framework = makeNixOS "framework" "x86_64-linux" [
        ./devices/framework/configuration.nix
      ];
      nixosConfigurations.nixos-testbench = makeNixOS "nixos-testbench" "x86_64-linux" [
        ./devices/nixos-testbench/configuration.nix
      ];

      # TODO: check/validate disko configuration
      diskoConfigurations.envy = import ./devices/envy/drives.nix;
      diskoConfigurations.framework = import ./devices/framework/drives.nix;

      # Expose home-manager modules for potential reuse
      homeManagerModules = {
        default = ./user-modules;
        android = ./user-modules/android.nix;
        coding-tools = ./user-modules/coding-tools.nix;
        ctf = ./user-modules/ctf;
        desktop = ./user-modules/desktop;
        gpg = ./user-modules/gpg.nix;
        hardware = ./user-modules/hardware;
        latex = ./user-modules/latex.nix;
        school = ./user-modules/school.nix;
      };

      # Expose NixOS system modules for potential reuse
      nixosModules = {
        desktop = ./system-modules/desktop.nix;
        cross-compilation = ./system-modules/cross-compilation.nix;
        steam = ./system-modules/steam.nix;
        virtualbox = ./system-modules/virtualbox.nix;
        docker = ./services/docker.nix;
      };
    };
}
