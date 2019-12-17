{ pkgs, lib, ... }:

let
  config = lib.mkIf config.hardware.pulseaudio.enable {
    services.udev.extraRules = ''
      ATTRS{idVendor}=="1038", ATTRS{idProduct}=="12ad", ENV{PULSE_PROFILE_SET}="steelseries-arctis-usb-audio.conf"
      ATTRS{idVendor}=="1038", ATTRS{idProduct}=="12AD", ENV{PULSE_PROFILE_SET}="steelseries-arctis-usb-audio.conf"
    '';
  };
in
{
  inherit (config);

  # Logitech
  hardware.logitech.enable = true;
  hardware.logitech.enableGraphical = false;

  # Steelseries headset
  services.udev.extraRules = ''
    ATTRS{idVendor}=="1038", ATTRS{idProduct}=="12ad", ENV{PULSE_PROFILE_SET}="steelseries-arctis-usb-audio.conf"
    ATTRS{idVendor}=="1038", ATTRS{idProduct}=="12AD", ENV{PULSE_PROFILE_SET}="steelseries-arctis-usb-audio.conf"
  '';

  # Yubikey
  services.udev.packages = with pkgs; [ yubikey-personalization libu2f-host ];
  services.pcscd.enable = true;

  # TLP (battery optimizer for laptop)
  services.tlp.enable = true;

  environment.systemPackages = [ pkgs.tpacpi-bat ];

}
