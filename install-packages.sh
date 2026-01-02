#!/bin/bash
# Install all packages from packages.txt

# Don't exit on error - some packages might fail
set +e

echo "📦 Installing packages from packages.txt..."

# Check if yay is installed
if ! command -v yay &> /dev/null; then
    echo "❌ yay is not installed. Please install it first:"
    echo "   git clone https://aur.archlinux.org/yay.git"
    echo "   cd yay && makepkg -si"
    exit 1
fi

# Install packages
if [ -f packages.txt ]; then
    # Filter out comments and empty lines
    PACKAGES=$(grep -v '^#' packages.txt | grep -v '^$' | tr '\n' ' ')
    
    if [ -z "$PACKAGES" ]; then
        echo "❌ No packages found in packages.txt!"
        exit 1
    fi
    
    echo "Installing: $PACKAGES"
    echo ""
    
    # Install with non-interactive mode
    # --noconfirm: don't ask for confirmation
    # --needed: skip if already installed
    # --batchinstall: don't show build progress for each package
    yay -S --needed --noconfirm --batchinstall $PACKAGES
    INSTALL_STATUS=$?
    
    if [ $INSTALL_STATUS -ne 0 ]; then
        echo ""
        echo "⚠️  Some packages failed to install. This might be normal if:"
        echo "   - Package doesn't exist in AUR (like cursor, logseq)"
        echo "   - Package needs manual installation"
        echo "   - Package is already installed"
        echo ""
        echo "Check the output above for details."
    fi
    
    echo ""
    echo "✅ Package installation complete!"
else
    echo "❌ packages.txt not found!"
    exit 1
fi
