{
  home.file.".config/neofetch/config.conf".text = ''
    print_info() {
        prin " "
        info "$(color 1) OS  " distro

        info "$(color 2) VER" kernel
        info "$(color 3)󱑍 UP " uptime
        info "$(color 4)󰏗 PKG" packages
        info "$(color 5)󰇄 DE " de
        info "$(color 6) CPU" cpu
        info "$(color 7) GPU" gpu
        info "$(color 8)󰍛 MEM" memory
        prin "$(color 1) $(color 2) $(color 3) $(color 4) $(color 5) $(color 6) $(color 7) $(color 8)"
    }
    title_fqdn="off"
    kernel_shorthand="on"
    distro_shorthand="off"
    os_arch="on"
    uptime_shorthand="on"
    memory_percent="off"
    memory_unit="mib"
    package_managers="on"
    shell_path="off"
    shell_version="on"
    speed_type="bios_limit"
    speed_shorthand="off"
    cpu_brand="on"
    cpu_speed="on"
    cpu_cores="logical"
    cpu_temp="off"
    gpu_brand="on"
    gpu_type="all"
    refresh_rate="off"
    gtk_shorthand="off"
    gtk2="on"
    gtk3="on"
    public_ip_host="http://ident.me"
    public_ip_timeout=2
    de_version="on"
    disk_show=('/')
    disk_subtitle="mount"
    disk_percent="on"
    music_player="mpv"
    song_shorthand="off"
    mpc_args=()
    colors=(distro)
    bold="on"
    underline_enabled="on"
    underline_char="-"
    separator=":"
    block_range=(0 15)
    color_blocks="on"
    block_width=3
    block_height=1
    col_offset="auto"
    bar_char_elapsed="-"
    bar_char_total="="
    bar_border="on"
    bar_length=15
    bar_color_elapsed="distro"
    bar_color_total="distro"
    cpu_display="off"
    memory_display="off"
    battery_display="off"
    disk_display="off"
    image_backend="kitty"
    image_source="auto"
    ascii_distro="NixOS_small"
    ascii_colors=(distro)
    ascii_bold="on"
    image_loop="off"
    crop_mode="normal"
    crop_offset="center"
    image_size="auto"
    gap=3
    yoffset=0
    xoffset=0
  '';
}
