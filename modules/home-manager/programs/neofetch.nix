{...}: let
  waifu = builtins.fetchurl rec {
    name = "waifu-${sha256}.png";
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake.svg";
    sha256 = "14mbpw8jv1w2c5wvfvj8clmjw0fi956bq5xf9s2q3my14far0as8";
  };
in {
  programs.neofetch = {
    enable = true;
    settings = {
      ascii_distro = "nixos";
    };
  };
}
