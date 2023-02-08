# This file (and the global directory) holds config that i use on all hosts
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
      ./locale.nix
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
    # font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    keyMap = "us";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings.LC_TIME = "en_US.UTF-8";
    supportedLocales = ["en_US.UTF-8/UTF-8"];
  };

  time = {
    timeZone = "Asia/Kolkata";
    hardwareClockInLocalTime = true;
  };

  environment = {
    binsh = "${pkgs.bash}/bin/bash";
    shells = with pkgs; [zsh];
    pathsToLink = ["/share/zsh"];

    systemPackages = lib.attrValues {
      inherit
        (pkgs)
        curl
        # gcc
        
        git
        # vim
        
        # hddtemp
        
        jq
        # lm_sensors
        
        # lz4
        
        ntfs3g
        # nvme-cli
        
        # p7zip
        
        # pciutils
        
        unrar
        unzip
        wget
        zip
        ffmpeg-full
        fzf
        man-pages
        pavucontrol
        pulseaudio
        vim
        ;
    };

    loginShellInit = ''
      dbus-update-activation-environment --systemd DISPLAY
    '';

    variables = {
      EDITOR = "vim";
      BROWSER = "firefox";
    };
  };

  programs = {
    bash.promptInit = ''eval "$(${pkgs.starship}/bin/starship init bash)"'';

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        # stdenv.cc.cc
        # openssl
        curl
        # glib
        # util-linux
        # glibc
        # icu
        # libunwind
        # libuuid
        # zlib
        libsecret
      ];
    };

    # adb.enable = true;
    dconf.enable = true;
    nm-applet.enable = true;
    seahorse.enable = true;

    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # npm = {
    #   enable = true;
    #   npmrc = ''
    #     prefix = ''${HOME}/.npm
    #     color = true
    #   '';
    # };

    # java = {
    #   enable = true;
    #   package = pkgs.jre;
    # };
  };

  services = {
    # blueman.enable = true;
    fwupd.enable = true;
    gvfs.enable = true;
    # lorri.enable = true;
    # udisks2.enable = true;
    # printing.enable = true;
    # fstrim.enable = true;

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
