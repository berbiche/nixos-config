{ pkgs, ... }:

{
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      grim
      light
      swayidle
      swaylock
      xwayland
      waybar
      mako
      volnoti
      xfce.xfce4-appfinder
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
  
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.displayManager.session = [
  #  { manage = "desktop";
  #    name = "Sway";
  #    start = ''
  #      ${pkgs.sway}/bin/sway &
  #      waitPID=$!
  #    '';
  #  }
  #];

  services.xserver.displayManager.extraSessionFilePackages = [ pkgs.sway ];

}
