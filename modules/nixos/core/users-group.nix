{
  lib,
  username,
  ...
}: let
  inherit (lib) mkAliasOptionModule;
in {
  imports = [
    (mkAliasOptionModule
      ["userPackages"] [
        "users"
        "users"
        username
        "packages"
      ])
  ];
  users = {
    mutableUsers = false;
    users.${username} = {
      initialPassword = "nixos";
      isNormalUser = true;
      extraGroups = ["wheel"];
    };
  };
}
