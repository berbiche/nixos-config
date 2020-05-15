{ config, lib, pkgs, ... }:

let
  packages = [ pkgs.playerctl pkgs.polkit pkgs.polkit_gnome ];
in
{
  imports = [
    ./sway.nix
    #./xfce.nix
    ./gnome.nix
    #./kde.nix
    ./steam.nix
  ];

  environment.systemPackages = packages;


  services.xserver.enable = true;
  #services.xserver.tty = 1;
  services.xserver.displayManager.defaultSession = "sway";

  services.xserver.useGlamor = true;
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.displayManager.gdm.wayland = true;
  services.xserver.displayManager.sddm.enable = false;
  services.xserver.displayManager.sddm = {
    #theme = "chili";
    autoLogin = {
      enable = false;
      user = "nicolas";
    };
  };
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.lightdm = {
    #theme = "chili";
    autoLogin = {
      enable = true;
      user = "nicolas";
      timeout = 5;
    };
    greeters.enso.enable = true;
  };

  services.xserver.libinput.enable = true;
  services.xserver.layout = "us";

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ libva ];
    #extraPackages = with pkgs; [ vaapiIntel vaapiVdpau libvdpau-va-gl intel-media-driver ];
    # package = (pkgs.mesa.override {
    #   galliumDrivers = [ "nouveau" "virgl" "swrast" "iris" ];
    # }).drivers;
  };


  security.polkit.enable = true;

  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = lib.optional (! config.services.xserver.desktopManager.gnome3.enable)
    [ pkgs.xdg-desktop-portal-gtk ];
  #xdg.portal.extraPortals = 
  #  let 
  #    not-exist = all (x: x != pkgs.xdg-desktop-portal-gtk) xdg.portal.extraPortals;
  #  in optionals not-exist [ pkgs.xdg-desktop-portal-gtk ]
  

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];

  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.printing.browsing = true;
  #services.printing.defaultShared = true;

  nixpkgs.config.chromium = {
    #enable = true;
    enableWideVine = true;
    useVaapi = true;
    enablePepperFlash = true;
  };

  services.redshift = {
    enable = false;
    extraOptions = [ "-m wayland" ];
    temperature.day = 6500;
    temperature.night = 5000;
    brightness.day = "0.8";
    brightness.night = "0.6";
  };
  
  fonts = {
    enableFontDir = true;
    #enableGhostscriptFonts = true;

    fonts = with pkgs; [
      anonymousPro
      corefonts
      dejavu_fonts
      freefont_ttf
      google-fonts
      inconsolata
      liberation_ttf
      noto-fonts
      noto-fonts-emoji
      hasklig
      powerline-fonts
      source-code-pro
      terminus_font
      ttf_bitstream_vera
      ubuntu_font_family
    ];

    fontconfig = {
      enable = true;
      hinting.enable = true;
      cache32Bit = true;
    };
  };

}
