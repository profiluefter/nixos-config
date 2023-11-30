{ config, ... }:
{
  users.mutableUsers = false;

  users.users.root.hashedPasswordFile = config.sops.secrets.rootHash.path;

  users.users.fabian = {
    uid = 1000;
    isNormalUser = true;
    description = "Fabian Gurtner";
    extraGroups = [ "networkmanager" "wheel" "syncthing" "docker" "keys" ];

    hashedPasswordFile = config.sops.secrets.userHash.path;

    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC08RPLOfIN7dNGxDwi1xlYjLCDp7sIGsPrSIP+++Io5VJY8W0FzXRbYEwpwuoBW3JG2RybRa/kjOcAm3uDTKEzGJYtiT8zIt/DCI7D8DgaWNAyQq6DMiFPVZDhT6UUKGTuDkfd+AmXbXuDgSxOk5W54GaVvOGPyUDCeN3h++RYnfUIgJ7MqX4YU5aUflMniIIFQGupizvDeB+AiAry+5+dknhQKu49Lny0esh7zc3/fvTYfMgXxEvdkJ1udxzkCPYWiPgM5Rr1LRuMlE+VOohTJtNDnED6cvqSnGHrhlHLTWq0LctYwCjl1ETxVD6/R8A+jVI453YQlDA30Z+Zelaf"
    ];
  };

  security.sudo.extraConfig = ''
    Defaults lecture = never
  '';
}
