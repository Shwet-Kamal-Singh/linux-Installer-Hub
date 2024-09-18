#!/bin/bash

# Function to check if a script exists and is executable
script_exists() {
    [[ -f "$1" && -x "$1" ]]
}

# Function to display the menu
display_menu() {
    clear
    echo "====================================="
    echo "    Multimedia Applications Installer"
    echo "====================================="
    echo "1. Install Audacity"
    echo "2. Install GIMP"
    echo "3. Install Kdenlive"
    echo "4. Install VLC"
    echo "5. Install All"
    echo "6. Exit"
    echo "====================================="
}

# Function to run a script
run_script() {
    if script_exists "$1"; then
        echo "Running $1..."
        bash "$1"
        echo "Press Enter to continue..."
        read
    else
        echo "Error: $1 not found or not executable."
        echo "Press Enter to continue..."
        read
    fi
}

# Main loop
while true; do
    display_menu
    read -p "Enter your choice (1-6): " choice

    case $choice in
        1) run_script "./install_audacity.sh" ;;
        2) run_script "./install_gimp.sh" ;;
        3) run_script "./install_kdenlive.sh" ;;
        4) run_script "./install_vlc.sh" ;;
        5)
            echo "Installing all multimedia applications..."
            for script in install_*.sh; do
                run_script "./$script"
            done
            ;;
        6)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            echo "Press Enter to continue..."
            read
            ;;
    esac
done