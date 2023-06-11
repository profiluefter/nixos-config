{
  description = "My system configuration";

  inputs.nixpkgs.url = "nixpkgs/nixos-23.05";
  inputs.nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

  inputs.sops-nix.url = "github:Mic92/sops-nix";

  inputs.peerix.url = "github:cid-chan/peerix";
  inputs.peerix.inputs.nixpkgs.follows = "nixpkgs";

  inputs.impermanence.url = "github:nix-community/impermanence";

  inputs.home-manager.url = "github:nix-community/home-manager/release-23.05";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  inputs.plasma-manager.url = "github:pjones/plasma-manager";
  inputs.plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.plasma-manager.inputs.home-manager.follows = "home-manager";

  inputs.nix-index-database.url = "github:Mic92/nix-index-database";
  inputs.nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, nixpkgs, nixpkgs-unstable, sops-nix, peerix, impermanence, home-manager, plasma-manager, ... }@args:
    let
      makeNixOSConfiguration = hostname: system: additionalConfig:
        let
          nixpkgsConfig = {
            inherit system;
            config.allowUnfree = true;
            config.android_sdk.accept_license = true;
          };
          pkgs = import nixpkgs nixpkgsConfig;
          lib2 = pkgs.callPackage ./lib {};
          overlay-unstable = final: prev: {
            unstable = import nixpkgs-unstable nixpkgsConfig;
          };
        in
        nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = { inherit system lib2; } // args;

          modules = [
            # overlay for pkgs.unstable
            { nixpkgs.overlays = [ overlay-unstable ]; }
            { system.configurationRevision = self.rev or "dirty"; }

            sops-nix.nixosModules.sops
            peerix.nixosModules.peerix
            impermanence.nixosModule
            home-manager.nixosModule

            { networking.hostName = hostname; }

            # General configuration
            ./configuration.nix
          ] ++ additionalConfig;
        };
    in {
      nixosConfigurations.fabian-ws = makeNixOSConfiguration "fabian-ws" "x86_64-linux" [ ./devices/fabian-ws/configuration.nix ];
      nixosConfigurations.envy = makeNixOSConfiguration "envy" "x86_64-linux" [ ./devices/envy/configuration.nix ];
      nixosConfigurations.nixos-testbench = makeNixOSConfiguration "nixos-testbench" "x86_64-linux" [ ./devices/nixos-testbench/configuration.nix ];
      nixosConfigurations.srv0 = makeNixOSConfiguration "srv0" "aarch64-linux" [ ./devices/srv0/configuration.nix ];
      nixosConfigurations.srv0-image = makeNixOSConfiguration "srv0" "aarch64-linux" [ ./devices/srv0/configuration.nix
        "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix" ];
      images.srv0 = self.nixosConfigurations.srv0-image.config.system.build.sdImage;
    };
}
