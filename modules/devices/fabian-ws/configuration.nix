{
  self,
  inputs,
  withSystem,
  ...
}:
{
  flake.nixosConfigurations.fabian-ws = withSystem "x86_64-linux" (
    { system, ... }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit system inputs;
      };
      modules = [
        self.nixosModules.fabian-ws
        ../../../configuration.nix
      ];
    }
  );

  flake.nixosModules.fabian-ws =
    { ... }:
    {
      imports = [
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
      ];

      networking.hostName = "fabian-ws";
    };
}
