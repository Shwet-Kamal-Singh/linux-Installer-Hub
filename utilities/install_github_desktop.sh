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

# Function to install GitHub Desktop
install_github_desktop() {
    detect_os
    echo "Detected OS: $OS"

    GITHUB_DESKTOP_VERSION="3.1.1-linux1"

    case "$OS" in
        Ubuntu|Debian|Linux\ Mint)
            echo "Installing GitHub Desktop on $OS..."
            wget -qO - https://packagecloud.io/shiftkey/desktop/gpgkey | sudo apt-key add -
            sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/shiftkey/desktop/any/ any main" > /etc/apt/sources.list.d/packagecloud-shiftkey-desktop.list'
            sudo apt update
            sudo apt install -y github-desktop
            ;;
        CentOS*|Red*Hat*)
            echo "Installing GitHub Desktop on CentOS/RHEL..."
            sudo rpm --import https://packagecloud.io/shiftkey/desktop/gpgkey
            sudo sh -c 'echo -e "[shiftkey]\nname=GitHub Desktop\nbaseurl=https://packagecloud.io/shiftkey/desktop/el/7/\$basearch\nenabled=1\ngpgcheck=0\nrepo_gpgcheck=1\ngpgkey=https://packagecloud.io/shiftkey/desktop/gpgkey" > /etc/yum.repos.d/shiftkey-desktop.repo'
            sudo yum install -y github-desktop
            ;;
        Fedora)
            echo "Installing GitHub Desktop on Fedora..."
            sudo rpm --import https://packagecloud.io/shiftkey/desktop/gpgkey
            sudo dnf config-manager --add-repo https://packagecloud.io/shiftkey/desktop/fedora/31/x86_64
            sudo dnf install -y github-desktop
            ;;
        *)
            echo "Unsupported operating system: $OS"
            echo "Please install GitHub Desktop manually."
            return 1
            ;;
    esac

    # Verify installation
    if command_exists github-desktop; then
        echo "GitHub Desktop has been successfully installed."
        github-desktop --version
    else
        echo "Failed to install GitHub Desktop. Please try installing it manually."
        return 1
    fi

    echo "GitHub Desktop installation completed."
    echo "You can now run GitHub Desktop by typing 'github-desktop' in the terminal or launching it from your application menu."
}

# Run the installation
install_github_desktop