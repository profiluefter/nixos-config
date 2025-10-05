{
  config,
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = [ pkgs.sops ];

  sops.gnupg.sshKeyPaths = [ ];
  # The persisted /etc isn't mounted fast enough
  sops.age.sshKeyPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];

  sops.secrets =
    let
      files = [
        {
          sopsFile = ./secrets/vpn.profiluefter.me.yaml;
          keyPrefix = "vpn-";
          keys = [
            "tls-crypt-v2"
            "key"
            "cert"
            "ca"
          ];
        }
        {
          sopsFile = ./secrets/users.yaml;
          keys = [
            "rootHash"
            "userHash"
          ];
          neededForUsers = true;
        }
        {
          sopsFile = ./secrets/school.yaml;
          keys = [
            "username"
            "password"
          ];
          keyPrefix = "school-";
          owner = "fabian";
        }
        {
          enable = config.services.peerix.enable;
          sopsFile = ./secrets/peerix.yaml;
          keys = [ "private" ];
          keyPrefix = "peerix-";
          owner = "peerix";
        }
        {
          sopsFile = ./secrets/gitlab.yaml;
          keys = [
            "username"
            "personal-access-token"
          ];
          keyPrefix = "gitlab-";
          owner = "fabian";
        }
      ];

      entries = builtins.map (
        {
          enable ? true,
          keyPrefix ? "",
          keys,
          ...
        }@args:
        let
          sopsAttrs = builtins.removeAttrs args [
            "enable"
            "keyPrefix"
            "keys"
          ];
          keyEntries = builtins.map (key: {
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
}
