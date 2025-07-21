{
  description = "My system configuration";

  inputs.nixpkgs.url = "nixpkgs/nixos-25.05";
  inputs.nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

  inputs.nixos-hardware.url = "github:NixOS/nixos-hardware";

  inputs.sops-nix.url = "github:Mic92/sops-nix";
  inputs.sops-nix.inputs.nixpkgs.follows = "nixpkgs";

  inputs.peerix.url = "github:cid-chan/peerix";

  inputs.impermanence.url = "github:nix-community/impermanence";

  inputs.home-manager.url = "github:nix-community/home-manager/release-25.05";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  inputs.plasma-manager.url = "github:pjones/plasma-manager";
  inputs.plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.plasma-manager.inputs.home-manager.follows = "home-manager";

  inputs.nix-index-database.url = "github:Mic92/nix-index-database";
  inputs.nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

  inputs.nix-alien.url = "github:thiagokokada/nix-alien";
  inputs.nix-alien.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nix-alien.inputs.nix-index-database.follows = "nix-index-database";

  inputs.nixos-generators.url = "github:nix-community/nixos-generators";
  inputs.nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

  inputs.disko.url = "github:nix-community/disko";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";

  inputs.treefmt-nix.url = "github:numtide/treefmt-nix";

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      sops-nix,
      peerix,
      impermanence,
      home-manager,
      disko,
      treefmt-nix,
      ...
    }@args:
    let
      treefmtEval = treefmt-nix.lib.evalModule nixpkgs.legacyPackages.x86_64-linux ./treefmt.nix;

      makeNixOSConfiguration =
        hostname: system: additionalConfig:
        let
          nixpkgsConfig = {
            inherit system;
            config.allowUnfree = true;
            config.android_sdk.accept_license = true;
          };
          pkgs = import nixpkgs nixpkgsConfig;
          lib2 = pkgs.callPackage ./lib { };
          nixpkgs-unstable-patched = pkgs.applyPatches {
            name = "nixpkgs-unstable-patched";
            src = nixpkgs-unstable;
            patches = [
              # jetbrains-jdk-jcef is unable to build with current nixpkgs-unstable
              (pkgs.fetchpatch {
                name = "jetbrains.jdk-fix";
                url = "https://patch-diff.githubusercontent.com/raw/NixOS/nixpkgs/pull/426285.patch";
                sha256 = "sha256-GJiY+D91ZJ+WMxffH4aekWGEM5rJZD60vK18TNTu0vM=";
              })
            ];
          };
          overlay-unstable = _final: _prev: {
            unstable = import nixpkgs-unstable-patched nixpkgsConfig;
          };
        in
        {
          inherit system;

          specialArgs = {
            inherit system lib2;
            inputs = args;
          };

          modules = [
            # overlay for pkgs.unstable
            { nixpkgs.overlays = [ overlay-unstable ]; }
            { system.configurationRevision = self.rev or "dirty"; }

            sops-nix.nixosModules.sops
            peerix.nixosModules.peerix
            impermanence.nixosModule
            home-manager.nixosModules.home-manager
            disko.nixosModules.disko

            { networking.hostName = hostname; }

            # General configuration
            ./configuration.nix
          ] ++ additionalConfig;
        };
      makeNixOS =
        hostname: system: additionalConfig:
        nixpkgs.lib.nixosSystem (makeNixOSConfiguration hostname system additionalConfig);
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
      # raspberry pi configuration is currently broken
      #      nixosConfigurations.srv0 = makeNixOS "srv0" "aarch64-linux" [ ./devices/srv0/configuration.nix ];

      diskoConfigurations.envy = import ./devices/envy/drives.nix;
      diskoConfigurations.framework = import ./devices/framework/drives.nix;

      apps.x86_64-linux.nixos-testbench-vm =
        let
          startScript = nixpkgs.legacyPackages.x86_64-linux.writeShellScript "run-nixos-testbench-vm" ''
            export NIX_DISK_IMAGE=$(${nixpkgs.legacyPackages.x86_64-linux.coreutils}/bin/mktemp --suffix -nixos-testbench-disk.img)
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

      apps.x86_64-linux.framework-install =
        let
          installScript = nixpkgs.legacyPackages.x86_64-linux.writeShellScript "do-framework-install" ''
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
            ${disko.packages.x86_64-linux.disko-install}/bin/disko-install --flake ${self}#framework --write-efi-boot-entries
          '';
        in
        {
          type = "app";
          program = "${installScript}";
        };

      #      packages.x86_64-linux.srv0-image = nixos-generators.nixosGenerate
      #        (
      #          (makeNixOSConfiguration "srv0" "aarch64-linux" [
      #            ./devices/srv0/configuration.nix
      #            {
      #              boot.loader.raspberryPi.enable = nixpkgs.lib.mkForce false;
      #              sdImage.compressImage = false;
      #            }
      #          ]) //
      #          { format = "sd-aarch64-installer"; }
      #        );

      # TODO: check/validate disko configuration
      checks.x86_64-linux.formatting = treefmtEval.config.build.check self;
      formatter.x86_64-linux = treefmtEval.config.build.wrapper;
    };
}
