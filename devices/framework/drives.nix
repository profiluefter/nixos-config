{
  disko.devices = {
    disk = {
      ssd = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-eui.0025385451a03f6d";
        content = {
          type = "gpt";
          partitions = {
            esp = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            btrfs = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-L btrfs" ];

                subvolumes =
                  let
                    subvolumes = {
                      "" = null; # to create subfolder
                      "/root" = "/";
                      "/root-blank" = null;
                      "/nix" = "/nix";
                      "/data" = "/data";
                      "/persist" = "/persist";
                      "/log" = "/var/log";
                    };
                    definitions = map (vol: {
                      name = "/nix-os" + vol;
                      value = rec {
                        mountpoint = builtins.getAttr vol subvolumes;
                        mountOptions =
                          if mountpoint != null then
                            [
                              "compress=zstd"
                              "noatime"
                            ]
                          else
                            [ ];
                      };
                    }) (builtins.attrNames subvolumes);
                  in
                  builtins.listToAttrs definitions;
              };
            };
          };
        };
      };
    };
  };
}
