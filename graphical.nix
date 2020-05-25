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
  services.xserver.displayManager.sddm = {
    enable = false;
    #theme = "chili";
    autoLogin = {
      enable = false;
      user = "nicolas";
    };
  };
  services.xserver.displayManager.lightdm = {
    enable = true;
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
    enableWideVine = true;
    useVaapi = true;
    enablePepperFlash = true;
  };

  fonts = {
    enableFontDir = true;
    enableDefaultFonts = true;

    fonts = with pkgs; [
      anonymousPro
      google-fonts
      inconsolata-nerdfont
      liberation_ttf
      noto-fonts
      noto-fonts-emoji
      nerdfonts
      hasklig
      powerline-fonts
      source-code-pro
      terminus-nerdfont
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
