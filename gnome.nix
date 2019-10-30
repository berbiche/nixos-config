{ config, pkgs, ... }:

{
  #services.xserver.enable = true;
  #services.xserver.useGlamor = true;
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome3.enable = true;
  #services.xserver.layout = "us";

  environment.systemPackages = with pkgs; [
    gnome3.dconf
    gnome3.gdm
    gnome3.gnome-desktop
    gnome3.gnome-session
  ];
  
  environment.gnome3.excludePackages = with pkgs; [
    gnome-usage
    gnome3.accerciser
    gnome3.cheese
    gnome3.evolution
    #gnome3.gedit
    gnome3.gnome-calculator
    gnome3.gnome-calendar
    gnome3.gnome-clocks
    gnome3.gnome-contacts
    gnome3.gnome-disk-utility
    gnome3.gnome-getting-started-docs
    gnome3.gnome-logs
    gnome3.gnome-music
    gnome3.gnome-online-accounts
    gnome3.gnome-power-manager
    gnome3.gnome-software
    gnome3.gnome-system-monitor
    gnome3.gnome-todo
    gnome3.gnome-user-docs
    gnome3.vinagre
    gnome3.yelp
    gnome3.yelp-tools
  ];
}
