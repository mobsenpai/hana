{
  imports = [
    ./nix

    ./fontconfig.nix
    ./users-group.nix
  ];

  # Set your time zone
  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Asia/Kolkata";
  };

  # Select internationalisation properties
  i18n.defaultLocale = "en_IN";
}
