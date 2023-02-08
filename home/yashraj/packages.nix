{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    pcmanfm
    # mpv-unwrapped
    pavucontrol
    pulseaudio
    nitch
    neovim
    htop
    killall

    # alsa-lib
    # alsa-plugins
    # alsa-tools
    alsa-utils
    # bandwhich
    # bc
    # blueberry
    # cairo
    # cached-nix-shell
    # cinnamon.nemo
    # coreutils
    dconf
    # findutils
    ffmpeg-full
    fzf
    # glib
    # glxinfo
    # gnumake
    # gnuplot
    # gnused
    # gnutls
    # grex
    # hyperfine
    # imagemagick
    # inotify-tools
    # keepassxc
    # libappindicator
    libnotify
    # libsecret
    # libreoffice-fresh
    luaPackages.lua
    # nodejs
    # pamixer
    # psmisc
    # python3
    # rsync
    # todo
    # trash-cli
    # util-linux
    # wirelesstools
    # xarchiver
    # xclip
    xdg-utils
    # xh
    # xorg.xhost
    # zoom-us
  ];
}
