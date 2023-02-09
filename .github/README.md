<!-- Mob's dotfiles -->
<!-- https://github.com/MobSenpai/dotfiles -->

[![NixOS](https://img.shields.io/badge/NixOS-unstable-informational.svg?style=flat-square&logo=nixos)](https://github.com/nixos/nixpkgs) [![AwesomeWM](https://img.shields.io/badge/AwesomeWM-master-blue.svg?style=flat-square&logo=lua)](https://github.com/awesomeWM/awesome)

[![NixOS_Check](https://github.com/MobSenpai/dotfiles/actions/workflows/check.yml/badge.svg)](https://github.com/MobSenpai/dotfiles/actions/workflows/check.yml) [![NixOS_Fmt](https://github.com/MobSenpai/dotfiles/actions/workflows/fmt.yml/badge.svg)](https://github.com/MobSenpai/dotfiles/actions/workflows/fmt.yml)

<p align="center"><a href="https://github.com/MobSenpai/dotfiles/blob/main/LICENSE"><img src="https://img.shields.io/static/v1.svg?style=flat&label=License&message=MIT&logoColor=cdd6f4&colorA=1e1e2e&colorB=cba6f7"/></a></p>

[![License](https://img.shields.io/static/v1.svg?style=flat&label=License&message=MIT&logoColor=cdd6f4&colorA=1e1e2e&colorB=cba6f7)](https://github.com/MobSenpai/dotfiles/blob/main/LICENSE)

<br>

<div align="justify">
<div align="center">

```ocaml
Mob's Dotfiles
```

```ocaml
NixOS / Home-Manager / Flake
```

</div>

## :snowflake: <samp>Information</samp>

<br>

<div>

<img align="right" src="https://i.imgur.com/u0DsgEx.png" width="30%" />

|                 |                        acer                         |
| :-------------: | :-------------------------------------------------: |
|       OS        |             [NixOS](https://nixos.org/)             |
| WM / Compositor |  [AwesomeWM](https://github.com/awesomeWM/awesome)  |
|    Terminal     | [Alacritty](https://github.com/alacritty/alacritty) |
|     Editor      |    [Vscode](https://github.com/microsoft/vscode)    |
|  File Manager   |     [Pcmanfm](https://github.com/lxde/pcmanfm)      |
|      Shell      |             [Zsh](https://www.zsh.org/)             |

<br>
<br>

<img src="https://i.imgur.com/PRFVvCt.png" alt="img" align="center" width="600px">

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
   $ nixos-install --flake 'github:MobSenpai/dotfiles#acer'
   ```

   or

   ```bash
   $ cd
   $ git clone https://github.com/MobSenpai/dotfiles.git
   $ cd dotfiles
   $ nixos-install --flake .#acer
   ```

7. Install the home manager configuration

   ```bash
   $ home-manager switch --flake 'github:yashraj/dotfiles#yashraj@acer'
   ```

   or (if already have dotfiles locally)

   ```bash
   $ cd dotfiles
   $ home-manager switch --flake .#yashraj@acer
   ```

8. Post install

   - After install check / match hardware-configuration.nix. Make sure or edit the disk/by-uuid to disk/by-label/ like it is in this repo for reproductable build.
   - passwd yashraj (`your username, must edit it in the repo for using your own name`)

9. Stuff still in mind

   ```ocaml
   - Config changes as per requirement or mood
   - Systemd
   - Hyprland
   ```

<br>

## :bulb: <samp>Acknowledgements</samp>

<table align="right">
  <tr>
    <th align="center">
      <sup><sub>:warning: WARNING :warning:</sub></sup>
    </th>
  </tr>
  <tr>
    <td align="center">
        <sup><sub><samp>It worked perfectly on my machine, but I can't guarantee it will work on your machine</samp></sub></sup>
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

**Other dotfiles**

- [rxyhn](https://github.com/rxyhn)
- [JavaCafe01](https://github.com/JavaCafe01)
- [raven2cz](https://github.com/raven2cz)
- [fortuneteller2k/nix-config](https://github.com/fortuneteller2k/nix-config)

</div>
