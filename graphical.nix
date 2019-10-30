{ config, lib, pkgs, ... }:

{
  imports = [
    ./sway.nix
    #./xfce.nix
    ./gnome.nix
    ./kde.nix
  ];

  # 
  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = with pkgs; [ vaapiIntel ];
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ vaapiIntel ];  

  security.polkit.enable = true;
  environment.systemPackages = [ pkgs.polkit pkgs.polkit_gnome ];

  services.xserver.enable = true;
  services.xserver.libinput.enable = true;

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

  services.emacs.enable = true;

  nixpkgs.config.chromium = {
    #enable = true;
    enableWideVine = true;
    useVaapi = true;
    enablePepperFlash = true;
  };

  services.redshift = {
    enable = true;
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
      ultimate.enable = true;
    };
  };
}
