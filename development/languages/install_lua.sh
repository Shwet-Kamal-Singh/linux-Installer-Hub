#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to detect the OS
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$NAME
    elif type lsb_release >/dev/null 2>&1; then
        OS=$(lsb_release -si)
    elif [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        OS=$DISTRIB_ID
    elif [ -f /etc/debian_version ]; then
        OS=Debian
    elif [ -f /etc/redhat-release ]; then
        OS=RedHat
    else
        OS=$(uname -s)
    fi
}

# Function to install Lua
install_lua() {
    detect_os
    echo "Detected OS: $OS"

    # Prompt user for Lua version
    echo "Which Lua version would you like to install?"
    echo "1) Lua 5.3"
    echo "2) Lua 5.4"
    read -p "Enter your choice (1-2): " lua_choice

    case $lua_choice in
        1) lua_version="5.3" ;;
        2) lua_version="5.4" ;;
        *) echo "Invalid choice. Exiting."; exit 1 ;;
    esac

    case "$OS" in
        Ubuntu|Debian)
            echo "Installing Lua on Ubuntu/Debian..."
            sudo apt update
            sudo apt install -y lua$lua_version liblua$lua_version-dev luarocks
            ;;
        CentOS*|Red*Hat*|Fedora)
            echo "Installing Lua on CentOS/RHEL/Fedora..."
            sudo yum install -y epel-release
            sudo yum install -y lua luarocks
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install Lua manually."
            return 1
            ;;
    esac

    # Verify installation
    if command_exists lua; then
        echo "Lua has been successfully installed."
        lua -v
    else
        echo "Failed to install Lua. Please try installing it manually."
        return 1
    fi

    # Install LuaRocks if not already installed
    if ! command_exists luarocks; then
        echo "Installing LuaRocks..."
        case "$OS" in
            Ubuntu|Debian)
                sudo apt install -y luarocks
                ;;
            CentOS*|Red*Hat*|Fedora)
                sudo yum install -y luarocks
                ;;
        esac
    fi

    echo "Lua installation completed."
    echo "You can now use 'luarocks' to install Lua packages."
}

# Run the installation
install_lua