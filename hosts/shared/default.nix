# This file (and the global directory) holds config that i use on all hosts
{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./fonts.nix
    ./locale.nix
    ./nix.nix
    ./network.nix
  ];
  console = {
    # font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    keyMap = "us";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = ["en_US.UTF-8/UTF-8"];
  };

  environment = {
    binsh = "${pkgs.bash}/bin/bash";
    shells = with pkgs; [zsh];

    systemPackages = with pkgs; [
      curl
      # gcc
      git
      vim
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
    ];

    # loginShellInit = ''
    #   dbus-update-activation-environment --systemd DISPLAY
    #   eval $(gnome-keyring-daemon --start --components=ssh)
    #   eval $(ssh-agent)
    # '';
    loginShellInit = ''
      dbus-update-activation-environment --systemd DISPLAY
      eval $(gnome-keyring-daemon --start --components=ssh)
    '';

    variables = {
      EDITOR = "vim";
      BROWSER = "firefox";
      # GDK_SCALE = "0.5";
    };
  };

  programs = {
    bash.promptInit = ''eval "$(${pkgs.starship}/bin/starship init bash)"'';

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
    pipewire-pulse.wantedBy = ["default.target"];
  };

  security = {
    rtkit.enable = true;
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [pkgs.apparmor-profiles];
    };
    polkit.enable = true;
  };
}
