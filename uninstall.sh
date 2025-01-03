#!/bin/bash

# Define the hidden directory where the binary was installed
INSTALL_DIR="$HOME/.local/bin"
SUPER_CAT_BINARY="$INSTALL_DIR/supercat"

# Check if the supercat binary exists in the installation directory
if [[ -f "$SUPER_CAT_BINARY" ]]; then
  echo "Removing supercat binary from $INSTALL_DIR..."
  rm "$SUPER_CAT_BINARY"
else
  echo "Error: supercat binary not found in $INSTALL_DIR."
  exit 1
fi

# Remove the PATH modification from .bashrc or .zshrc (whichever was used)
if [[ -f "$HOME/.bashrc" ]]; then
  echo "Removing $INSTALL_DIR from .bashrc..."
  sed -i '/export PATH=.*\.local\/bin/d' "$HOME/.bashrc"
elif [[ -f "$HOME/.zshrc" ]]; then
  echo "Removing $INSTALL_DIR from .zshrc..."
  sed -i '/export PATH=.*\.local\/bin/d' "$HOME/.zshrc"
else
  echo "Warning: Could not find .bashrc or .zshrc to remove PATH modification."
fi

# Reload the shell configuration to apply the changes
source "$HOME/.bashrc" 2>/dev/null || source "$HOME/.zshrc" 2>/dev/null

# Confirm successful uninstallation
echo "supercat has been uninstalled successfully."

