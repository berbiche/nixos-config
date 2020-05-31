# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let
  host = lib.fileContents ./hostname;
  user = "nicolas";
in
{
  imports =
    [ <nixpkgs/nixos/modules/hardware/all-firmware.nix>
      ./hardware-configuration.nix
      ./cachix.nix
      ./overlays
      ./zsh.nix
      ./graphical.nix
      ./all-packages.nix
      ./physical.nix
      ./services.nix
      (./. + "/host/${host}.nix")
    ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.09"; # Did you read the comment?

  boot.cleanTmpDir = true;
  
  # Automatic GC of nix files
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 10d";
  };

  environment.systemPackages = [ pkgs.cachix ];
  nix.trustedUsers = [ user "root" ];

  networking.hostName = host; # Define your hostname.
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluez5;
  #hardware.bluetooth.package = pkgs.bluezFull;

  # Virtualization
  virtualisation.docker.enable = true;

  # Set your time zone.
  time.timeZone = "America/Montreal";
  # Location provider
  location.provider = "geoclue2";

  networking.firewall.enable = true;
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
  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    uid = 1000;
    group = user;
    extraGroups = [ "wheel" "networkmanager" "input" "audio" "video" "docker" "vboxusers" ];
  };
}
