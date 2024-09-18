#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if script exists and is executable
script_exists() {
    [[ -f "$1" && -x "$1" ]]
}

# Function to display the menu
display_menu() {
    clear
    echo "====================================="
    echo "       Development Tools Installer   "
    echo "====================================="
    echo "1. Install Git"
    echo "2. Install Sublime Text"
    echo "3. Install Visual Studio Code"
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
        1)
            run_script "./install_git.sh"
            ;;
        2)
            run_script "./install_sublime_text.sh"
            ;;
        3)
            run_script "./install_vscode.sh"
            ;;
        4)
            run_script "./install_git.sh"
            run_script "./install_sublime_text.sh"
            run_script "./install_vscode.sh"
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