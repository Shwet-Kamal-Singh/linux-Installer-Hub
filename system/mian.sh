#!/bin/bash

# Function to check if a script exists and is executable
script_exists() {
    [[ -f "$1" && -x "$1" ]]
}

# Function to display the menu
display_menu() {
    clear
    echo "====================================="
    echo "      System Tools Installer         "
    echo "====================================="
    echo "1. Install GParted"
    echo "2. Install Synaptic"
    echo "3. Install Timeshift"
    echo "4. Install All"
    echo "5. Exit"
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
    read -p "Enter your choice (1-5): " choice

    case $choice in
        1) run_script "./install_gparted.sh" ;;
        2) run_script "./install_synaptic.sh" ;;
        3) run_script "./install_timeshift.sh" ;;
        4)
            echo "Installing all system tools..."
            for script in install_*.sh; do
                run_script "./$script"
            done
            ;;
        5)
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