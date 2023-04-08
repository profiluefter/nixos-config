{
  description = "My system configuration";

  inputs.nixpkgs.url = "nixpkgs/nixos-22.11";
#  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";
  inputs.nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

  inputs.sops-nix.url = "github:Mic92/sops-nix";

  inputs.peerix.url = "github:cid-chan/peerix";
  inputs.peerix.inputs.nixpkgs.follows = "nixpkgs";

  inputs.impermanence.url = "github:nix-community/impermanence";

  inputs.home-manager.url = "github:nix-community/home-manager/release-22.05";
#  inputs.home-manager.url = "github:nix-community/home-manager/master";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  inputs.plasma-manager.url = "github:pjones/plasma-manager";
  inputs.plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.plasma-manager.inputs.home-manager.follows = "home-manager";

  outputs = { self, nixpkgs, nixpkgs-unstable, sops-nix, peerix, impermanence, home-manager, plasma-manager }:
    let
      overlay-unstable = system: final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
          config.android_sdk.accept_license = true;
        };
      };
      makeNixOSConfiguration = hostname: system: additionalConfig:
        nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            # overlay for pkgs.unstable
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ (overlay-unstable system) ]; })

            sops-nix.nixosModules.sops

            peerix.nixosModules.peerix

            impermanence.nixosModule

            home-manager.nixosModule

            ({ ... }: {
              # Include plasma-manager
              home-manager.users.fabian.imports = [
                plasma-manager.homeManagerModules.plasma-manager
              ];

              # Set peerix package
              services.peerix.package = peerix.packages.${system}.peerix;
            })

            { networking.hostName = hostname; }

            # General configuration
            ./configuration.nix
          ] ++ additionalConfig;
        };
    in rec {
      nixosConfigurations.fabian-ws = makeNixOSConfiguration "fabian-ws" "x86_64-linux" [ ./devices/fabian-ws/configuration.nix ];
      nixosConfigurations.envy = makeNixOSConfiguration "envy" "x86_64-linux" [ ./devices/envy/configuration.nix ];
      nixosConfigurations.nixos-testbench = makeNixOSConfiguration "nixos-testbench" "x86_64-linux" [ ./devices/nixos-testbench/configuration.nix ];
      nixosConfigurations.srv0 = makeNixOSConfiguration "srv0" "aarch64-linux" [ ./devices/srv0/configuration.nix ];
      nixosConfigurations.srv0-image = makeNixOSConfiguration "srv0" "aarch64-linux" [ ./devices/srv0/configuration.nix
        "${nixpkgs}/nixos/modules/installer/cd-dvd/sd-image-aarch64.nix" ];
      images.srv0 = nixosConfigurations.srv0-image.config.system.build.sdImage;
    };
}
