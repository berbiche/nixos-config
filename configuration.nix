{ config, pkgs, lib, ... }:

let
  host = lib.fileContents ./hostname;
  user = "nicolas";
  home-manager-configuration = "/home/nicolas/dotfiles/home.nix";
  #home-manager = "${builtins.fetchTarball "https://github.com/rycee/home-manager/archive/master.tar.gz"}/nixos";
  home-manager = /home/nicolas/dev/github.com/home-manager/nixos;
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
      ./services.nix
      (./. + "/host/${host}.nix")
      home-manager
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
    home = "/home/${user}";
    extraGroups = [ "wheel" "networkmanager" "input" "audio" "video" "docker" "vboxusers" ];
  };
  home-manager.users.${user} = import home-manager-configuration;
  home-manager.useUserPackages = true;

  # Logitech
  hardware.logitech.enable = true;
  hardware.logitech.enableGraphical = false;

  # Forward journald logs to VTT 1
  services.journald.extraConfig = ''
    FordwardToConsole=yes
    TTYPath=/dev/tty1
  '';

  # Steelseries headset
  services.udev.extraRules = lib.optionalString config.hardware.pulseaudio.enable ''
    ATTRS{idVendor}=="1038", ATTRS{idProduct}=="12ad", ENV{PULSE_PROFILE_SET}="steelseries-arctis-7-usb-audio.conf"
    ATTRS{idVendor}=="1038", ATTRS{idProduct}=="12AD", ENV{PULSE_PROFILE_SET}="steelseries-arctis-7-usb-audio.conf"
  '';

  # Yubikey
  services.udev.packages = with pkgs; [ yubikey-personalization libu2f-host ];
  services.pcscd.enable = true;

  # Enable insults on wrong `sudo` password input
  security.sudo.extraConfig = lib.mkAfter ''
    Defaults !insults
    Defaults:%wheel insults
  '';
}
