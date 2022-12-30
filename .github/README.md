<!-- Yash Raj's dotfiles -->
<!-- https://github.com/itsmeyashraj/dotfiles -->

[![NixOS](https://img.shields.io/badge/NixOS-unstable-informational.svg?style=flat&logo=nixos)](https://github.com/nixos/nixpkgs)

[![NixOS_Check](https://github.com/itsmeyashraj/dotfiles/actions/workflows/check.yml/badge.svg)](https://github.com/itsmeyashraj/dotfiles/actions/workflows/check.yml) [![NixOS_Fmt](https://github.com/itsmeyashraj/dotfiles/actions/workflows/fmt.yml/badge.svg)](https://github.com/itsmeyashraj/dotfiles/actions/workflows/fmt.yml)

<br>

<div align="justify">
<div align="center">

```ocaml
Yash Raj's Dotfiles
```

<br>

```ocaml
NixOS / Home-Manager / Flake
```

<br>

<p align="center">

# Setup details

- WM : Awesome
- Distro : Nixos(home manager + flake)
- Terminal : Kitty
- Bar : Wibar

[![Alt text](https://i.imgur.com/woPmvSU.png)](https://imgur.com)

</p>

</div>

<br>

## :wrench: <samp>Installation</samp>

1. Download minimal iso

2. Boot into the installer.

3. Switch to root user: `sudo su -`

4. Partitioning

   We create a 512MB EFI boot partition (`/dev/sda3`), 2GB swap partition on (`/dev/sda2`) and the rest will be our filesystem (`/dev/sda1`). `replace sda* with your disk name - use lsblk`

   Format disk as gpt

   ```bash
   $ parted /dev/sda -- mklabel gpt
   ```

   Make the above mentioned partitions:

   ```bash
   $ parted /dev/sda -- mkpart primary 512MiB -2GiB
   $ parted /dev/sda -- mkpart primary linux-swap -2GiB 100%
   $ parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB
   $ parted /dev/sda -- set 3 esp on
   ```

   Assing the partitions the respective types. (`/dev/sda1 type = btrfs label = root`), (`/dev/sda2 type = swap label = swap`), (`/dev/sda3 type = efiboot label = boot`). Labelling will later help in hardware-config.nix

   ```bash
   $ mkfs.btrfs -L root /dev/sda1 -f
   $ mkswap -L swap /dev/sda2
   $ mkfs.fat -F 32 -n boot /dev/sda3
   ```

   Mount partitions

   ```bash
   $ mount -t btrfs -o compress=zstd,noatime,ssd,space_cache=v2 /dev/sda1 /mnt
   $ mkdir -p /mnt/boot
   $ mount /dev/disk/by-label/boot /mnt/boot
   $ swapon /dev/sda2
   ```

5. Enable flakes & git

   ```bash
   $ nix-shell -p nixFlakes
   $ nix-env -iA nixos.git
   ```

6. Install nixos from flake
   ```bash
   $ nixos-install --flake github:itsmeyashraj/dotfiles#acer --impure
   ```
   or
   ```bash
   $ cd
   $ git clone https://github.com/itsmeyashraj/dotfiles.git
   $ cd dotfiles
   $ nixos-install --flake .#acer
   ```
7. Post install

- After install check / match hardware-configuration.nix. Make sure or edit the disk/by-uuid to disk/by-label/ like it is in this repo for reproductable build.
- passwd yashraj (`your username, must edit it in the repo for using your own name`)

<br>
<br>
<br>

## :snowflake: <samp>Info</samp>

<table align="right">
  <tr>
    <th align="center">
      <sup><sub>:warning:</sub></sup>
    </th>
  </tr>
  <tr>
    <td align="center">
        <sup><sub><samp>If you stole something from here at least give us credits!</samp></sub></sup>
      </a>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="https://nixos.wiki/wiki/Overview_of_the_NixOS_Linux_distribution">
        <sup><sub><samp>Powered by NixOS/Linux x86_64</samp></sub></sup>
      </a>
    </td>
  </tr>
</table>

<p align="center"><a href="https://github.com/rxyhn/dotfiles/blob/main/LICENSE"><img src="https://img.shields.io/static/v1.svg?style=flat&label=License&message=MIT&logoColor=cdd6f4&colorA=1e1e2e&colorB=cba6f7"/></a></p>

</div>
