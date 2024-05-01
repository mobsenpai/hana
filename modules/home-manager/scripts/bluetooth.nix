{
  config,
  lib,
  pkgs,
  ...
}: let
  bluetooth = pkgs.writeShellScriptBin "bluetooth" ''
    #!/usr/bin/env bash

    # Constants
    divider="---------"
    goback="Back"

    # Checks if bluetooth controller is powered on
    power_on() {
        if ${pkgs.bluez}/bin/bluetoothctl show | grep -q "Powered: yes"; then
            return 0
        else
            return 1
        fi
    }

    # Toggles power state
    toggle_power() {
        if power_on; then
            ${pkgs.bluez}/bin/bluetoothctl power off
            show_menu
        else
            if rfkill list bluetooth | grep -q 'blocked: yes'; then
                rfkill unblock bluetooth && sleep 3
            fi
            ${pkgs.bluez}/bin/bluetoothctl power on
            show_menu
        fi
    }

    # Checks if controller is scanning for new devices
    scan_on() {
        if ${pkgs.bluez}/bin/bluetoothctl show | grep -q "Discovering: yes"; then
            echo "Scan: on"
            return 0
        else
            echo "Scan: off"
            return 1
        fi
    }

    # Toggles scanning state
    toggle_scan() {
        if scan_on; then
            kill $(pgrep -f "${pkgs.bluez}/bin/bluetoothctl scan on")
            ${pkgs.bluez}/bin/bluetoothctl scan off
            show_menu
        else
            ${pkgs.bluez}/bin/bluetoothctl scan on &
            echo "Scanning..."
            sleep 5
            show_menu
        fi
    }

    # Checks if controller is able to pair to devices
    pairable_on() {
        if ${pkgs.bluez}/bin/bluetoothctl show | grep -q "Pairable: yes"; then
            echo "Pairable: on"
            return 0
        else
            echo "Pairable: off"
            return 1
        fi
    }

    # Toggles pairable state
    toggle_pairable() {
        if pairable_on; then
            ${pkgs.bluez}/bin/bluetoothctl pairable off
            show_menu
        else
            ${pkgs.bluez}/bin/bluetoothctl pairable on
            show_menu
        fi
    }

    # Checks if controller is discoverable by other devices
    discoverable_on() {
        if ${pkgs.bluez}/bin/bluetoothctl show | grep -q "Discoverable: yes"; then
            echo "Discoverable: on"
            return 0
        else
            echo "Discoverable: off"
            return 1
        fi
    }

    # Toggles discoverable state
    toggle_discoverable() {
        if discoverable_on; then
            ${pkgs.bluez}/bin/bluetoothctl discoverable off
            show_menu
        else
            ${pkgs.bluez}/bin/bluetoothctl discoverable on
            show_menu
        fi
    }

    # Checks if a device is connected
    device_connected() {
        device_info=$(${pkgs.bluez}/bin/bluetoothctl info "$1")
        if echo "$device_info" | grep -q "Connected: yes"; then
            return 0
        else
            return 1
        fi
    }

    # Toggles device connection
    toggle_connection() {
        if device_connected $1; then
            ${pkgs.bluez}/bin/bluetoothctl disconnect $1
            device_menu "$device"
        else
            ${pkgs.bluez}/bin/bluetoothctl connect $1
            device_menu "$device"
        fi
    }

    # Checks if a device is paired
    device_paired() {
        device_info=$(${pkgs.bluez}/bin/bluetoothctl info "$1")
        if echo "$device_info" | grep -q "Paired: yes"; then
            echo "Paired: yes"
            return 0
        else
            echo "Paired: no"
            return 1
        fi
    }

    # Toggles device paired state
    toggle_paired() {
        if device_paired $1; then
            ${pkgs.bluez}/bin/bluetoothctl remove $1
            device_menu "$device"
        else
            ${pkgs.bluez}/bin/bluetoothctl pair $1
            device_menu "$device"
        fi
    }

    # Checks if a device is trusted
    device_trusted() {
        device_info=$(${pkgs.bluez}/bin/bluetoothctl info "$1")
        if echo "$device_info" | grep -q "Trusted: yes"; then
            echo "Trusted: yes"
            return 0
        else
            echo "Trusted: no"
            return 1
        fi
    }

    # Toggles device connection
    toggle_trust() {
        if device_trusted $1; then
            ${pkgs.bluez}/bin/bluetoothctl untrust $1
            device_menu "$device"
        else
            ${pkgs.bluez}/bin/bluetoothctl trust $1
            device_menu "$device"
        fi
    }

    # Prints a short string with the current bluetooth status
    # Useful for status bars like polybar, etc.
    print_status() {
        if power_on; then
            printf ''

            mapfile -t paired_devices < <(${pkgs.bluez}/bin/bluetoothctl paired-devices | grep Device | cut -d ' ' -f 2)
            counter=0

            for device in ''${paired_devices[@]}; do
                if device_connected $device; then
                    device_alias=$(${pkgs.bluez}/bin/bluetoothctl info $device | grep "Alias" | cut -d ' ' -f 2-)

                    if [ $counter -gt 0 ]; then
                        printf ", %s" "$device_alias"
                    else
                        printf " %s" "$device_alias"
                    fi

                    ((counter++))
                fi
            done
            printf "\n"
        else
            echo ""
        fi
    }

    # A submenu for a specific device that allows connecting, pairing, and trusting
    device_menu() {
        device=$1

        # Get device name and mac address
        device_name=$(echo $device | cut -d ' ' -f 3-)
        mac=$(echo $device | cut -d ' ' -f 2)

        # Build options
        if device_connected $mac; then
            connected="Connected: yes"
        else
            connected="Connected: no"
        fi
        paired=$(device_paired $mac)
        trusted=$(device_trusted $mac)
        options="$connected\n$paired\n$trusted\n$divider\n$goback\nExit"

        # Open wofi menu, read chosen option
        chosen="$(echo -e "$options" | $wofi_command "$device_name")"

        # Match chosen option to command
        case $chosen in
            "" | $divider)
                echo "No option chosen."
                ;;
            $connected)
                toggle_connection $mac
                ;;
            $paired)
                toggle_paired $mac
                ;;
            $trusted)
                toggle_trust $mac
                ;;
            $goback)
                show_menu
                ;;
        esac
    }

    # Opens a wofi menu with current bluetooth status and options to connect
    show_menu() {
        # Get menu options
        if power_on; then
            power="Power: on"

            # Human-readable names of devices, one per line
            # If scan is off, will only list paired devices
            devices=$(${pkgs.bluez}/bin/bluetoothctl devices | grep Device | cut -d ' ' -f 3-)

            # Get controller flags
            scan=$(scan_on)
            pairable=$(pairable_on)
            discoverable=$(discoverable_on)

            # Options passed to wofi
            options="$devices\n$divider\n$power\n$scan\n$pairable\n$discoverable\nExit"
        else
            power="Power: off"
            options="$power\nExit"
        fi

        # Open wofi menu, read chosen option
        chosen="$(echo -e "$options" | $wofi_command "Bluetooth")"

        # Match chosen option to command
        case $chosen in
            "" | $divider)
                echo "No option chosen."
                ;;
            $power)
                toggle_power
                ;;
            $scan)
                toggle_scan
                ;;
            $discoverable)
                toggle_discoverable
                ;;
            $pairable)
                toggle_pairable
                ;;
            *)
                device=$(${pkgs.bluez}/bin/bluetoothctl devices | grep "$chosen")
                # Open a submenu if a device is selected
                if [[ $device ]]; then device_menu "$device"; fi
                ;;
        esac
    }

    # Wofi command to pipe into, can add any options here
    wofi_command="${pkgs.wofi}/bin/wofi -d -i -p"

    case "$1" in
        --status)
            print_status
            ;;
        *)
            show_menu
            ;;
    esac

  '';
in {
  options = {
    myHome.bluetooth.enable = lib.mkEnableOption "Enables bluetooth";
  };
  config = lib.mkIf config.myHome.bluetooth.enable {
    home.packages = [bluetooth];
  };
}
