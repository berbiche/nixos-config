{ config, lib, pkgs, ... }:

{
  boot.kernelParams = [ "amd_iommu=pt" "iommu=soft" "nordrand" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  #hardware.firmware = [ pkgs.amdgpu-navi10-firmware ];

  environment.systemPackages = with pkgs; [ linuxPackages.rtlwifi_new ];

  services.kmscon = {
    enable = true;
    autologinUser = "nicolas";
    hwRender = true;
  };

  fileSystems."/mnt/games" =
    { device = "/dev/disk/by-uuid/D896285496283602";
      fsType = "ntfs";
      options = [ "auto" "nofail" "remove_hiberfile" "noatime" "nodiratime" "uid=1000" "gid=1000" "dmask=007" "fmask=007" "big_writes" ];
    };
}
