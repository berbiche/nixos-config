{ config, lib, pkgs, ... }:

{
  boot.kernelParams = [ "amd_iommu=pt" "iommu=soft" "nordrand" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  #hardware.firmware = [ pkgs.amdgpu-navi10-firmware ];

  #boot.kernelPatches = [ {
  #  name = "Enable AMD fTPM";
  #  patch = null;
  #  extraConfig = ''
  #    TEE n
  #    OPTEE n
  #    TCG_TPM y
  #    TCG_FTPM_TEE y
  #  '';
  #} ];

  environment.systemPackages = with pkgs; [
    dislocker
  ];

  fileSystems."/mnt/games" =
    { device = "/dev/disk/by-uuid/D896285496283602";
      fsType = "ntfs";
      options = [ "auto" "nofail" "remove_hiberfile" "noatime" "nodiratime" "uid=1000" "gid=1000" "dmask=007" "fmask=007" "big_writes" ];
    };

  virtualisation.virtualbox = {
    host.enable = false;
    #host.enableExtensionPack = true;
    host.headless = false;
  };

  #programs.java = {
  #  enable = true;
  #  package = pkgs.openjdk11;
  #};
}
