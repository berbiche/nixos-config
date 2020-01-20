# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      <nixpkgs/nixos/modules/hardware/all-firmware.nix>
      ./hardware-configuration.nix
      ./cachix.nix
      ./zsh.nix
      ./graphical.nix
      ./all-packages.nix
      ./physical.nix
      ./services.nix
      ./wireguard.nix
      ./host/g-word.nix
    ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  boot.cleanTmpDir = true;

  # FS settings
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];
  
  
  # Automatic GC of nix files
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 10d";
  };

  environment.systemPackages = [ pkgs.cachix ];
  nix.trustedUsers = [ "nicolas" "root" ];
 
  
  networking.hostName = "g-word"; # Define your hostname.
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
  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.guest.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";
  console.font = "Lat2-Terminus16";
  console.keyMap = "us";

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

  networking.firewall.enable = true;
  networking.firewall.allowPing = true;
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 21027 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" "9.9.9.9" ];

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

  security.sudo.extraConfig = ''
    Defaults:%wheel insults
    Defaults !insults
  '';
}
