#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install Flutter
install_flutter() {
    echo "Installing Flutter..."

    # Check if git is installed
    if ! command_exists git; then
        echo "Git is not installed. Please install git first."
        return 1
    fi

    # Create a directory for Flutter
    FLUTTER_DIR="$HOME/flutter"
    if [ ! -d "$FLUTTER_DIR" ]; then
        echo "Creating Flutter directory..."
        mkdir -p "$FLUTTER_DIR"
    fi

    # Clone Flutter repository
    echo "Cloning Flutter repository..."
    git clone https://github.com/flutter/flutter.git -b stable "$FLUTTER_DIR"

    # Add Flutter to PATH
    echo "Adding Flutter to PATH..."
    echo 'export PATH="$PATH:$HOME/flutter/bin"' >> "$HOME/.bashrc"
    source "$HOME/.bashrc"

    # Run flutter doctor
    echo "Running flutter doctor..."
    "$FLUTTER_DIR/bin/flutter" doctor

    # Verify installation
    if command_exists flutter; then
        echo "Flutter has been successfully installed."
        flutter --version
    else
        echo "Failed to install Flutter. Please try installing it manually."
        return 1
    fi

    # Install Android SDK (optional)
    read -p "Do you want to install Android SDK? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Installing Android SDK..."
        sudo apt-get update
        sudo apt-get install -y android-sdk
        echo 'export ANDROID_HOME="/usr/lib/android-sdk"' >> "$HOME/.bashrc"
        echo 'export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"' >> "$HOME/.bashrc"
        source "$HOME/.bashrc"
    fi

    echo "Flutter installation completed."
}

# Run the installation
install_flutter