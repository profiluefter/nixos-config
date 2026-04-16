{ inputs, self, ... }:
{
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

            self.modules.nixos.default
            self.modules.nixos.secrets
            self.modules.nixos.workstation

            # TODO: move to individual device configs
            self.modules.nixos.gaming
            self.modules.nixos.virtualbox
            self.modules.nixos.plasma

            inputs.impermanence.nixosModule
            inputs.home-manager.nixosModules.home-manager
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
      nixosConfigurations.nixos-testbench = makeNixOS "nixos-testbench" "x86_64-linux" [
        ../devices/nixos-testbench/configuration.nix
      ];
    };
}
