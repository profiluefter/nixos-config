{ config, ... }:
{
  sops.gnupg.sshKeyPaths = [];
  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  sops.secrets.rootHash = {
    neededForUsers = true;
    format = "binary";
    sopsFile = ./secrets/users/rootHash.json;
  };

  sops.secrets.userHash = {
    neededForUsers = true;
    format = "binary";
    sopsFile = ./secrets/users/userHash.json;
  };

  sops.secrets.schoolUser = {
    format = "binary";
    sopsFile = ./secrets/school/username.json;
    mode = "0400";
    owner = config.users.users.fabian.name;
    group = config.users.users.fabian.group;
  };

  sops.secrets.schoolPassword = {
    format = "binary";
    sopsFile = ./secrets/school/password.json;
    mode = "0400";
    owner = config.users.users.fabian.name;
    group = config.users.users.fabian.group;
  };
}
