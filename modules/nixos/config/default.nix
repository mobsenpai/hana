{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    ./nix
    
    ./fontconfig.nix
    ./users-group.nix

    inputs.home-manager.nixosModules.default
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    verbose = true;
    sharedModules = [
      inputs.self.homeManagerModules.shell
      {home.stateVersion = lib.mkForce config.system.stateVersion;}
    ];
  };

  # Set your time zone
  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Asia/Kolkata";
  };

  # Select internationalisation properties
  i18n.defaultLocale = "en_IN";

  hardware = {
    bluetooth.enable = true;
    enableRedistributableFirmware = true;
    pulseaudio.enable = false;
  };

  services = {
    # Enable MTP
    gvfs.enable = true;

    # Enable sound with pipewire
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };

  security = {
    pam.services = {
      gtklock = {};
    };

    polkit.enable = true;
    rtkit.enable = true;
  };
}
