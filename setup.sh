#!/bin/bash

# ================================================================
# Omarchy Dotfiles Setup Script
# ================================================================
# 
# This script sets up the custom Omarchy configuration files
# Run this after installing Omarchy to apply all customizations
# ================================================================

set -e

echo "🚀 Setting up Omarchy customizations..."

# Create necessary directories
mkdir -p ~/.config/hypr/scripts
mkdir -p ~/prompts

# Copy configuration files
echo "📁 Copying configuration files..."
cp hypr/bindings.conf ~/.config/hypr/
cp hypr/envs.conf ~/.config/hypr/
cp hypr/windows.conf ~/.config/hypr/
cp hypr/archivist.sh ~/.config/hypr/scripts/

# Make scripts executable
chmod +x ~/.config/hypr/scripts/archivist.sh

# Backup existing zshrc if it exists
if [ -f ~/.zshrc ]; then
    echo "💾 Backing up existing .zshrc to .zshrc.backup"
    cp ~/.zshrc ~/.zshrc.backup
fi

# Copy zshrc
cp .zshrc ~/.zshrc

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Reload Hyprland: SUPER + CTRL + R"
echo "2. Reload shell: source ~/.zshrc"
echo "3. Test Archivist: SUPER + A"
echo ""
echo "Your customizations are now active!"
