{
  # Allow updating the firmware of various components
  services.fwupd.enable = true;

  # Enable CUPS to print documents.
  #services.printing.enable = true;

  # Enable locate
  services.locate.enable = true;
  services.acpid.enable = true;

  services.blueman.enable = true;

  # networking.wireguard.enable = true;
}
