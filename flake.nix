{
  description = "My system configuration";

  inputs.nixpkgs.url = "nixpkgs/nixos-22.05";
#  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";
  inputs.nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

  inputs.sops-nix.url = "github:Mic92/sops-nix";

  inputs.impermanence.url = "github:nix-community/impermanence";

  inputs.home-manager.url = "github:nix-community/home-manager/release-22.05";
#  inputs.home-manager.url = "github:nix-community/home-manager/master";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  inputs.plasma-manager.url = "github:pjones/plasma-manager";
  inputs.plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.plasma-manager.inputs.home-manager.follows = "home-manager";

  outputs = { self, nixpkgs, nixpkgs-unstable, sops-nix, impermanence, home-manager, plasma-manager }:
    let
      system = "x86_64-linux";
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
          config.android_sdk.accept_license = true;
        };
      };
      makeNixOSConfiguration = hostname: additionalConfig:
        nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            host = hostname;
          };

          modules = [
            # overlay for pkgs.unstable
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })

            sops-nix.nixosModules.sops

            impermanence.nixosModule

            home-manager.nixosModule

            # Include plasma-manager
            ({ ... }: {
              home-manager.users.fabian.imports = [
                plasma-manager.homeManagerModules.plasma-manager
              ];
            })

            ./configuration.nix
          ] ++ additionalConfig;
        };
    in {
      nixosConfigurations.fabian-ws = makeNixOSConfiguration "fabian-ws" [ ./devices/fabian-ws/configuration.nix ];
      nixosConfigurations.envy = makeNixOSConfiguration "envy" [ ./devices/envy/configuration.nix ];
    };
}
