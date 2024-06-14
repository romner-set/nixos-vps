{
  disko.devices = {
    disk = {
      vdb = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            EFI = {
              priority = 1;
              name = "EFI";
              start = "1M";
              end = "1024M";
              type = "EF00";
              content = {
                type = "filesystem";
                extraArgs = ["-n EFI"];
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            ROOT = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-f -L ROOT"];
                subvolumes = {
                  "@nix" = {
                    mountOptions = ["compress=zstd" "noatime"];
                    mountpoint = "/nix";
                  };
                  /*
                    "@nixos" = {
                    mountOptions = ["compress=zstd" "noatime"];
                    mountpoint = "/etc/nixos";
                  };
                  */
                  "@data" = {
                    mountOptions = ["compress=zstd" "noatime"];
                    mountpoint = "/data";
                  };
                };
                #mountpoint = "/btrfs";
              };
            };
          };
        };
      };
    };
  };
}
