{ config, lib, pkgs, ... }:

{
  boot.kernelParams = [ "amd_iommu=pt" "iommu=soft" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  #hardware.firmware = [ pkgs.amdgpu-navi10-firmware ];

  environment.systemPackages = with pkgs; [ linuxPackages.rtlwifi_new ];

  fileSystems."/mnt/games" =
    { device = "/dev/disk/by-uuid/D896285496283602";
      fsType = "ntfs";
      options = [ "rw" "noatime" "nodiratime" "uid=1000" "gid=1000" "dmask=007" "fmask=007" "big_writes" ];
    };
}
