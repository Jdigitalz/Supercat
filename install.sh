#!/bin/bash

# Get the current directory where the script is located
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

# Create a temporary virtual environment in the current directory
VENV_DIR="$SCRIPT_DIR/venv"
if [[ ! -d "$VENV_DIR" ]]; then
  python3 -m venv "$VENV_DIR"
fi

# Activate the virtual environment
source "$VENV_DIR/bin/activate"

# Upgrade pip to ensure we're using the latest version
echo "I am not frozen!!!"
pip install --upgrade pip

# Install the latest version of PyInstaller
pip install pyinstaller rich

# Check if the supercat.py script exists in the current directory
if [[ ! -f "$SCRIPT_DIR/supercat.py" ]]; then
  echo "Error: supercat.py not found in the current directory."
  deactivate
  exit 1
fi

# Use PyInstaller to create a single binary from supercat.py
pyinstaller --onefile "$SCRIPT_DIR/supercat.py"

# Check if the dist directory was created and the binary exists
if [[ ! -f "$SCRIPT_DIR/dist/supercat" ]]; then
  echo "Error: PyInstaller failed to create the supercat binary."
  deactivate
  exit 1
fi

# Move the generated binary to the current directory
mv "$SCRIPT_DIR/dist/supercat" "$SCRIPT_DIR/supercat"

# Clean up by removing the dist and build directories, and the virtual environment
rm -rf "$SCRIPT_DIR/dist" "$SCRIPT_DIR/build" "$VENV_DIR"

# Deactivate the virtual environment
deactivate

# Check if the supercat binary is now in the current directory
if [[ ! -f "$SCRIPT_DIR/supercat" ]]; then
  echo "Error: supercat binary not found after PyInstaller process."
  exit 1
fi

# Define the hidden directory where the binary will be installed
INSTALL_DIR="$HOME/.local/bin"

# Create the directory if it doesn't exist
mkdir -p "$INSTALL_DIR"

# Move the supercat binary to the hidden directory
mv "$SCRIPT_DIR/supercat" "$INSTALL_DIR/supercat"

# Set executable permissions for the binary
chmod +x "$INSTALL_DIR/supercat"

# Add the install directory to the user's PATH if not already present
if ! echo "$PATH" | grep -q "$INSTALL_DIR"; then
  echo "Adding $INSTALL_DIR to PATH..."

  # Update the PATH in .bashrc or .zshrc, depending on the shell
  if [[ -f "$HOME/.bashrc" ]]; then
    echo "export PATH=\$PATH:$INSTALL_DIR" >> "$HOME/.bashrc"
  elif [[ -f "$HOME/.zshrc" ]]; then
    echo "export PATH=\$PATH:$INSTALL_DIR" >> "$HOME/.zshrc"
  else
    echo "Warning: Could not find .bashrc or .zshrc to update PATH."
  fi

  # Reload the shell configuration to update the PATH
  source "$HOME/.bashrc" 2>/dev/null || source "$HOME/.zshrc" 2>/dev/null
fi

# Confirm successful installation
echo "supercat has been installed successfully!"

