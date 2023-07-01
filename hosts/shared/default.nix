{
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./fonts.nix
      ./nix.nix
      ./networking.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs outputs;};
  };

  nixpkgs = {
    overlays = [
      outputs.overlays.default
      inputs.nixpkgs-f2k.overlays.stdenvs
    ];

    config = {
      allowUnfree = true;
    };
  };

  console = {
    useXkbConfig = true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings.LC_TIME = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
    ];
  };

  time = {
    timeZone = "Asia/Kolkata";
    hardwareClockInLocalTime = true;
  };

  environment = with pkgs; {
    binsh = lib.getExe bash;
    shells = [zsh];
    pathsToLink = ["/share/zsh"];

    systemPackages = lib.attrValues {
      inherit
        (pkgs)
        alsa-utils
        # blueman
        
        dbus
        dconf
        ffmpeg-full
        gcc
        git
        glib
        libnotify
        libsecret
        ntfs3g
        p7zip
        pamixer
        pavucontrol
        playerctl
        pulseaudio
        unrar
        unzip
        vim
        vlc
        tree
        wget
        zathura
        ;
    };

    loginShellInit = ''
      dbus-update-activation-environment --all
    '';

    variables = {
      EDITOR = "vim";
      BROWSER = "firefox";
    };
  };

  programs = {
    # adb.enable = true;
    bash.promptInit = ''eval "$(${lib.getExe pkgs.starship} init bash)"'';
    dconf.enable = true;

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        curl
        libsecret
      ];
    };

    seahorse.enable = true;
    zsh.enable = true;
  };

  services = {
    # blueman.enable = true;
    fstrim.enable = true;
    fwupd.enable = true;
    gvfs.enable = true;

    dbus = {
      enable = true;
      packages = with pkgs; [dconf gcr];
    };

    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };
    udev.packages = with pkgs; [gnome.gnome-settings-daemon];

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  hardware.pulseaudio.enable = false;

  systemd.user.services = {
    pipewire.wantedBy = ["default.target"];
    pipewire-pulse = {
      path = [pkgs.pulseaudio];
      wantedBy = ["default.target"];
    };
  };

  security = {
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [pkgs.apparmor-profiles];
    };

    pam = {
      loginLimits = [
        {
          domain = "@wheel";
          item = "nofile";
          type = "soft";
          value = "524288";
        }
        {
          domain = "@wheel";
          item = "nofile";
          type = "hard";
          value = "1048576";
        }
      ];

      services = {
        lightdm.enableGnomeKeyring = true;
        login.enableGnomeKeyring = true;
      };
    };

    polkit.enable = true;
    rtkit.enable = true;
  };
}
