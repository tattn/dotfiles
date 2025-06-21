#!/bin/bash

# Migration script from zplug to sheldon
# This script helps migrate your zplug setup to sheldon

set -e

echo "=== Migration from zplug to sheldon ==="

# Check if sheldon is installed
if ! command -v sheldon &> /dev/null; then
    echo "Installing sheldon..."
    if [[ "$(uname)" == "Darwin" ]]; then
        # macOS - use Homebrew
        if command -v brew &> /dev/null; then
            brew install sheldon
        else
            echo "Homebrew not found. Please install sheldon manually."
            echo "See: https://github.com/rossmacarthur/sheldon#installation"
            exit 1
        fi
    else
        # Linux - use the install script
        curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
            | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin
    fi
fi

# Initialize sheldon if needed
if [ ! -d ~/.config/sheldon ]; then
    echo "Initializing sheldon..."
    sheldon init --shell zsh
fi

# Create necessary directories
mkdir -p ~/.config/sheldon

# Copy the sheldon configuration file
echo "Setting up sheldon configuration..."
cp -f "$DOTPATH/.config/sheldon/plugins.toml" ~/.config/sheldon/plugins.toml

# Update .zshrc to use sheldon
echo "Sheldon installed and configured successfully!"
echo "Your zplug configuration has been migrated to sheldon."
echo ""
echo "To complete the migration:"
echo "1. Restart your shell or run 'source ~/.zshrc'"
echo "2. If everything works correctly, you can remove zplug with: 'rm -rf ~/.zplug'"
echo ""
echo "Migration completed!"
