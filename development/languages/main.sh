#!/bin/bash

# Function to check if a script exists and is executable
script_exists() {
    [[ -f "$1" && -x "$1" ]]
}

# Function to display the menu
display_menu() {
    clear
    echo "====================================="
    echo "    Programming Language Installer   "
    echo "====================================="
    echo "1. Install Clang"
    echo "2. Install Dart"
    echo "3. Install .NET"
    echo "4. Install Flutter"
    echo "5. Install GCC"
    echo "6. Install Go"
    echo "7. Install Java"
    echo "8. Install Lua"
    echo "9. Install Mono"
    echo "10. Install Node.js"
    echo "11. Install Python"
    echo "12. Install Ruby"
    echo "13. Install All"
    echo "14. Exit"
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
    read -p "Enter your choice (1-14): " choice

    case $choice in
        1) run_script "./install_clang.sh" ;;
        2) run_script "./install_dart.sh" ;;
        3) run_script "./install_dotnet.sh" ;;
        4) run_script "./install_flutter.sh" ;;
        5) run_script "./install_gcc.sh" ;;
        6) run_script "./install_go.sh" ;;
        7) run_script "./install_java.sh" ;;
        8) run_script "./install_lua.sh" ;;
        9) run_script "./install_mono.sh" ;;
        10) run_script "./install_nodejs.sh" ;;
        11) run_script "./install_python.sh" ;;
        12) run_script "./install_ruby.sh" ;;
        13)
            echo "Installing all languages and tools..."
            for script in install_*.sh; do
                run_script "./$script"
            done
            ;;
        14)
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