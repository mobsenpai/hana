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
        curl
        git
        jq
        killall
        libnotify
        ntfs3g
        unrar
        unzip
        vim
        wget
        ffmpeg-full
        gcc
        fzf
        man-pages
        pamixer
        pavucontrol
        pulseaudio
        p7zip
        zip
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
    bash.promptInit = ''eval "$(${lib.getExe pkgs.starship} init bash)"'';

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        curl
        libsecret
      ];
    };

    # adb.enable = true;
    dconf.enable = true;
    nm-applet.enable = true;
    seahorse.enable = true;
  };

  services = {
    # blueman.enable = true;
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

    logind = {
      extraConfig = ''
        HandlePowerKey=suspend-then-hibernate
        HibernateDelaySec=3600
      '';
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
    rtkit.enable = true;
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [pkgs.apparmor-profiles];
    };
    # pam = {};
    polkit.enable = true;
  };
}
