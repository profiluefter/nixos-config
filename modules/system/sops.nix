{ inputs, ... }:
{
  flake.nixosModules.secrets =
    {
      pkgs,
      lib,
      ...
    }:
    {
      imports = [
        inputs.sops-nix.nixosModules.sops
      ];

      environment.systemPackages = [ pkgs.sops ];

      sops.gnupg.sshKeyPaths = [ ];
      # The persisted /etc isn't mounted fast enough
      sops.age.sshKeyPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];

      sops.secrets =
        let
          files = [
            {
              sopsFile = ../../secrets/vpn.profiluefter.me.yaml;
              keyPrefix = "vpn-";
              keys = [
                "tls-crypt-v2"
                "key"
                "cert"
                "ca"
              ];
            }
            {
              sopsFile = ../../secrets/users.yaml;
              keys = [
                "rootHash"
                "userHash"
              ];
              neededForUsers = true;
            }
          ];

          entries = map (
            {
              enable ? true,
              keyPrefix ? "",
              keys,
              ...
            }@args:
            let
              sopsAttrs = removeAttrs args [
                "enable"
                "keyPrefix"
                "keys"
              ];
              keyEntries = map (key: {
                name = keyPrefix + key;
                value = {
                  inherit key;
                }
                // sopsAttrs;
              }) keys;
            in
            if enable then keyEntries else [ ]
          ) files;
        in
        builtins.listToAttrs (lib.lists.flatten entries);
    };
}
