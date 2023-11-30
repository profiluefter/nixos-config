{
  description = "My system configuration";

  inputs.nixpkgs.url = "nixpkgs/nixos-23.11";
  inputs.nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

  inputs.sops-nix.url = "github:Mic92/sops-nix";
  inputs.sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  inputs.sops-nix.inputs.nixpkgs-stable.follows = "nixpkgs";

  inputs.peerix.url = "github:cid-chan/peerix";

  inputs.impermanence.url = "github:nix-community/impermanence";

  inputs.home-manager.url = "github:nix-community/home-manager/release-23.11";
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

  outputs = { self, nixpkgs, nixpkgs-unstable, sops-nix, peerix, impermanence, home-manager, nixos-generators, disko, ... }@args:
    let
      makeNixOSConfiguration = hostname: system: additionalConfig:
        let
          nixpkgsConfig = {
            inherit system;
            config.allowUnfree = true;
            config.android_sdk.accept_license = true;
          };
          pkgs = import nixpkgs nixpkgsConfig;
          lib2 = pkgs.callPackage ./lib { };
          overlay-unstable = final: prev: {
            unstable = import nixpkgs-unstable nixpkgsConfig;
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
            home-manager.nixosModule
            disko.nixosModules.disko

            { networking.hostName = hostname; }

            # General configuration
            ./configuration.nix
          ] ++ additionalConfig;
        };
      makeNixOS = hostname: system: additionalConfig:
        nixpkgs.lib.nixosSystem (makeNixOSConfiguration hostname system additionalConfig);
    in
    {
      nixosConfigurations.fabian-ws = makeNixOS "fabian-ws" "x86_64-linux" [ ./devices/fabian-ws/configuration.nix ];
      nixosConfigurations.envy = makeNixOS "envy" "x86_64-linux" [ ./devices/envy/configuration.nix ];
      nixosConfigurations.nixos-testbench = makeNixOS "nixos-testbench" "x86_64-linux" [ ./devices/nixos-testbench/configuration.nix ];
      nixosConfigurations.srv0 = makeNixOS "srv0" "aarch64-linux" [ ./devices/srv0/configuration.nix ];

      diskoConfigurations.envy = import ./devices/envy/drives.nix;

      packages.x86_64-linux.srv0-image = nixos-generators.nixosGenerate
        (
          (makeNixOSConfiguration "srv0" "aarch64-linux" [
            ./devices/srv0/configuration.nix
            {
              boot.loader.raspberryPi.enable = nixpkgs.lib.mkForce false;
              sdImage.compressImage = false;
            }
          ]) //
          { format = "sd-aarch64-installer"; }
        );

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };
}
