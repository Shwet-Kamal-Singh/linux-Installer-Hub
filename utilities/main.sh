#!/bin/bash

# Function to check if a script exists and is executable
script_exists() {
    [[ -f "$1" && -x "$1" ]]
}

# Function to display the menu
display_menu() {
    clear
    echo "====================================="
    echo "      Utility Tools Installer        "
    echo "====================================="
    echo "1. Install AnyDesk"
    echo "2. Install Brave Browser"
    echo "3. Install Google Chrome"
    echo "4. Install Etcher"
    echo "5. Install GitHub Desktop"
    echo "6. Install KeePassXC"
    echo "7. Install OBS Studio"
    echo "8. Install TeamViewer"
    echo "9. Install All"
    echo "10. Exit"
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
    read -p "Enter your choice (1-10): " choice

    case $choice in
        1) run_script "./install_anydesk.sh" ;;
        2) run_script "./install_brave.sh" ;;
        3) run_script "./install_chrome.sh" ;;
        4) run_script "./install_etcher.sh" ;;
        5) run_script "./install_github_desktop.sh" ;;
        6) run_script "./install_keepassxc.sh" ;;
        7) run_script "./install_obs_studio.sh" ;;
        8) run_script "./install_teamviewer.sh" ;;
        9)
            echo "Installing all utility tools..."
            for script in install_*.sh; do
                run_script "./$script"
            done
            ;;
        10)
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