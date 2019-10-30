# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      <nixpkgs/nixos/modules/hardware/all-firmware.nix>
      ./hardware-configuration.nix
      ./zsh.nix
      ./graphical.nix
      ./all-packages.nix
      ./physical.nix
      ./services.nix
      ./wireguard.nix
    ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

  #boot.plymouth.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  boot.cleanTmpDir = true;
  # Boot loader settings
  
  # Resume device can be a swapfile
  #boot.resumeDevice = "/dev/mapper/nixos-enc";

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    systemd-boot.enable = false;
    grub = {
      enable = true;
      version = 2;
      enableCryptodisk = true;
      useOSProber = true;
      device = "nodev";
      efiSupport = true;
#       gfxmodeEfi = "1024x768";
    };
  };
#   boot.initrd.luks = {
#     cryptoModules = [ "aes" "xts" "sha512" ];
#     yubikeySupport = true;
#     devices = [ {
#       name = "nixos-enc";
#       preLVM = false;
#       yubikey = {
#         slot = 2;
#         twoFactor = false;
#         storage.device = "/dev/disk/by-partuuid/f6a9cde0-5728-46d1-aaa3-eae945f76aae";
#       };
#     } ];
#   };

  # FS settings
#   fileSystems."/".options = [ "noatime" "nodiratime" ];
#   fileSystems."/boot/efi".options = [ "defaults,noauto" ];
  
  
  # Automatic GC of nix files
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 10d";
  };
 
  
  networking.hostName = "thixxos"; # Define your hostname.
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluez5;
  #hardware.bluetooth.package = pkgs.bluezFull;
  #hardware.bluetooth.extraConfig = ''
  #  [General]
  #  Enable=Source,Sink,Media,Socket
  #'';

  # Virtualization
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  #virtualisation.virtualbox.guest.enable = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_CA.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/Montreal";
  # Location provider
  location.provider = "geoclue2";
  
  
  # Allow installing non-free packages
  nixpkgs.config.allowUnfree = true;


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  #programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = true;
  networking.firewall.allowPing = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    package = pkgs.pulseaudioFull;
    support32Bit = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nicolas = {
    isNormalUser = true;
    shell = pkgs.zsh;
    uid = 1000;
    group = "nicolas";
    extraGroups = [ "wheel" "networkmanager" "input" "audio" "video" "docker" "vboxusers" ];
  };

  environment.variables = { EDITOR = "nvim"; };

}
