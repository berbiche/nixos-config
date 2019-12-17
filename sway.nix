{ pkgs, ... }:

let
  url = "https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz";
  waylandOverlay = (import (builtins.fetchTarball url));
in
{
  nixpkgs.overlays = [ waylandOverlay ];

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      xwayland

      swayidle
      swaylock
      swaybg

      gebaar-libinput  # libinput gestures utility
      wtype            # xdotool, but for wayland

      grim
      slurp
      wf-recorder      # wayland screenrecorder

      waybar
      mako
      volnoti
      kanshi
      wl-clipboard
      wdisplays


      wofi
      xfce.xfce4-appfinder

      # TODO: more steps required to use this?
      xdg-desktop-portal-wlr # xdg-desktop-portal backend for wlroots
    ];

    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      # needs qt5.qtwayland in systemPackages
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      # Fix for some Java AWT applications (e.g. Android Studio),
      # use this if they aren't displayed properly:
      export _JAVA_AWT_WM_NONREPARENTING=1
    '';
  };

  #programs.light.enable = true;
  hardware.brightnessctl.enable = true;
  
  services.xserver.displayManager.sddm.enable = true;

  services.xserver.displayManager.extraSessionFilePackages = [ pkgs.sway ];

  # environment.systemPackages = with pkgs; [
  #   # other compositors/window-managers
  #   waybox   # An openbox clone on Wayland
  #   bspwc    # Wayland compositor based on BSPWM
  #   cage     # A Wayland kiosk (runs a single app fullscreen)
  #   wayfire   # 3D wayland compositor
  #   wf-config # wayfire config manager
  # ];
}
