{ ssd-disk, ... }:
{
  disko.devices.disk = {
    ssd = {
      type = "disk";
      device = ssd-disk;
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
            };
          };
          btrfs = {
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [ "-L btrfs" ];

              subvolumes = let
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
                    mountOptions = if
                      mountpoint != null
                    then
                      [ "compress=zstd" "noatime" ]
                    else
                      null;
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
}
