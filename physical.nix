{ pkgs, ... }:

{
  # Logitech
  hardware.logitech.enable = true;
  hardware.logitech.enableGraphical = false;

  # Yubikey
  services.udev.packages = with pkgs; [ yubikey-personalization libu2f-host ];
  services.pcscd.enable = true;
}
