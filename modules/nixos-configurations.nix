{ inputs, self, ... }:
{
  flake =
    let
      makeNixOSConfiguration = hostname: system: additionalConfig: {
        inherit system;

        specialArgs = {
          inherit system inputs;
        };

        modules = [
          self.nixosModules.default
          self.nixosModules.users
          self.nixosModules.secrets
          self.nixosModules.workstation
          self.nixosModules.containers

          # TODO: move to individual device configs
          self.nixosModules.gaming
          self.nixosModules.syncthing
          self.nixosModules.virtualbox
          self.nixosModules.plasma

          inputs.impermanence.nixosModule
          inputs.disko.nixosModules.disko

          { networking.hostName = hostname; }

          # General configuration
          ../configuration.nix
        ]
        ++ additionalConfig;
      };
      makeNixOS =
        hostname: system: additionalConfig:
        inputs.nixpkgs.lib.nixosSystem (makeNixOSConfiguration hostname system additionalConfig);
    in
    {
      nixosConfigurations.fabian-ws = makeNixOS "fabian-ws" "x86_64-linux" [
        ../devices/fabian-ws/configuration.nix
      ];
      nixosConfigurations.envy = makeNixOS "envy" "x86_64-linux" [ ../devices/envy/configuration.nix ];
      nixosConfigurations.framework = makeNixOS "framework" "x86_64-linux" [
        ../devices/framework/configuration.nix
      ];
      #nixosConfigurations.nixos-testbench = makeNixOS "nixos-testbench" "x86_64-linux" [
      #  ../devices/nixos-testbench/configuration.nix
      #];
    };
}
