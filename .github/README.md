<!-- Mob's dotfiles -->
<!-- https://github.com/MobSenpai/dotfiles -->

<p align="center">
<a href="https://github.com/nixos/nixpkgs"><img src="https://img.shields.io/badge/NixOS-unstable-informational.svg?style=flat&logo=nixos&logoColor=CAD3F5&colorA=24273A&colorB=8AADF4"></a> <a href="https://awesomewm.org"><img src="https://img.shields.io/static/v1?label=AwesomeWM&message=master&style=flat&logo=awesomewm&colorA=24273A&colorB=8AADF4&logoColor=CAD3F5"/></a>
</p>

<p align="center">
<a href="https://github.com/MobSenpai/dotfiles/actions/workflows/check.yml"><img src="https://github.com/MobSenpai/dotfiles/actions/workflows/check.yml/badge.svg"></a> <a href="https://github.com/MobSenpai/dotfiles/actions/workflows/fmt.yml"><img src="https://github.com/MobSenpai/dotfiles/actions/workflows/fmt.yml/badge.svg"/></a>
</p>

<p align="center">
<a href="https://github.com/MobSenpai/dotfiles/blob/main/LICENSE"><img src="https://img.shields.io/static/v1.svg?style=flat&label=License&message=MIT&logoColor=CAD3F5&colorA=24273A&colorB=8AADF4"/></a>
</p>

<br>

<div align="justify">
<div align="center">

```ocaml
Mob's Dotfiles
```

<br>

<p align="center">
  <img src="https://i.imgur.com/3eCVWGT.png" width="500px" alt="OS banner"/>
</p>

<br>

```ocaml
NixOS / Home-Manager / Flake
```

<p align="center">
  <img src="https://i.imgur.com/16RObqJ.png" alt="Screenshot"/>
</p>

</div>

<br>

## :snowflake: <samp>Information</samp>

|                 |                                             acer                                              |
| :-------------: | :-------------------------------------------------------------------------------------------: |
|       OS        |                                  [NixOS](https://nixos.org/)                                  |
| WM / Compositor |                       [AwesomeWM](https://github.com/awesomeWM/awesome)                       |
|    Terminal     |                         [Kitty](https://github.com/kovidgoyal/kitty)                          |
|     Editor      | [Nvchad](https://github.com/NvChad/NvChad) + [Vscodium](https://github.com/VSCodium/vscodium) |
|  File Manager   |                          [Pcmanfm](https://github.com/lxde/pcmanfm)                           |
|      Shell      |                          [Bash](https://www.gnu.org/software/bash/)                           |

<br>
<br>

## :wrench: <samp>Installation</samp>

I highly recommend creating your own configurations based on these dotfiles. Use this repository as a reference to customize your setup according to your preferences and requirements. Please note that these dotfiles were created for my specific hardware configuration, so use them at your own risk.

But anyway… let's move on to the installation process!

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

7. Reboot, login as root, and change the password for your user using passwd

8. Log in as normal user

9. Install the home manager configuration

   ```bash
   $ home-manager switch --flake 'github:yashraj/dotfiles#yuki@acer'
   ```

   or (if already have dotfiles locally)

   ```bash
   $ cd dotfiles
   $ home-manager switch --flake .#yuki@acer
   ```

10. Check wiki for more info. AwesomeWM config has moved to <a href="https://github.com/MobSenpai/sugoi.git">MobSenpai/sugoi</a>

<br>
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

**Thanks to all these amazing people**

- [rxyhn](https://github.com/rxyhn)
- [JavaCafe01](https://github.com/JavaCafe01)
- [siduck](https://github.com/siduck)

</div>
