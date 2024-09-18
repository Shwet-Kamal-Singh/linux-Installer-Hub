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

# Function to install TeamViewer
install_teamviewer() {
    detect_os
    echo "Detected OS: $OS"

    TEAMVIEWER_URL="https://download.teamviewer.com/download/linux/teamviewer_amd64.deb"

    case "$OS" in
        Ubuntu|Debian|Linux\ Mint)
            echo "Installing TeamViewer on $OS..."
            wget -O teamviewer.deb "$TEAMVIEWER_URL"
            sudo apt update
            sudo apt install -y ./teamviewer.deb
            rm teamviewer.deb
            ;;
        CentOS*|Red*Hat*)
            echo "Installing TeamViewer on CentOS/RHEL..."
            sudo yum install -y https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm
            ;;
        Fedora)
            echo "Installing TeamViewer on Fedora..."
            sudo dnf install -y https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm
            ;;
        Arch\ Linux|Manjaro)
            echo "Installing TeamViewer on Arch/Manjaro..."
            git clone https://aur.archlinux.org/teamviewer.git
            cd teamviewer
            makepkg -si --noconfirm
            cd ..
            rm -rf teamviewer
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install TeamViewer manually."
            return 1
            ;;
    esac

    # Verify installation
    if command_exists teamviewer; then
        echo "TeamViewer has been successfully installed."
        teamviewer --version
    else
        echo "Failed to install TeamViewer. Please try installing it manually."
        return 1
    fi

    echo "TeamViewer installation completed."
    echo "You can now run TeamViewer by typing 'teamviewer' in the terminal or launching it from your application menu."
    echo "Note: You may need to start the TeamViewer daemon with 'sudo teamviewer --daemon start'"
}

# Run the installation
install_teamviewer