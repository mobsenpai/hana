{
  username,
  hostname,
  ...
}: {
  networking = {
    hostName = hostname;
    networkmanager = {
      enable = true;
    };

    useDHCP = false;
  };

  users.users.${username}.extraGroups = ["networkmanager"];
}
