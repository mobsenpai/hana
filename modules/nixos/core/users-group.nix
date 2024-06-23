{username, ...}: {
  users = {
    mutableUsers = false;
    users.${username} = {
      initialPassword = "nixos";
      isNormalUser = true;
      extraGroups = ["wheel"];
    };
  };
}
