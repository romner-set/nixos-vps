{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "virtio_scsi" "sr_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = ["defaults" "size=2G" "mode=755"];
  };

  /*
    fileSystems."/boot" = {
    device = "/dev/disk/by-label/EFI";
    fsType = "vfat";
  };

  fileSystems."/data" = {
    device = "/dev/disk/by-label/ROOT";
    fsType = "btrfs";
    options = ["subvol=@data"];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-label/ROOT";
    fsType = "btrfs";
    options = ["subvol=@nix"];
  };

  fileSystems."/etc/nixos" = {
    device = "/dev/disk/by-label/ROOT";
    fsType = "btrfs";
    options = ["subvol=@nixos"];
  };
  */

  swapDevices = [];
}
