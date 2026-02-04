#!/bin/bash

# Check if script is run as root (required to write to /bin)
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (e.g., with sudo)"
  exit 1
fi

# Resolve the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

COMMANDS_DIR="$SCRIPT_DIR/commands"
SHORTCUTS_FILE="$SCRIPT_DIR/shortcuts.sh"

# Check and execute shortcuts.sh if it exists
if [ -f "$SHORTCUTS_FILE" ]; then
  echo "Found shortcuts.sh. Executing..."
  sudo bash "$SHORTCUTS_FILE"
else
  echo "shortcuts.sh not found. Skipping execution."
fi

# Check if the commands directory exists
if [ ! -d "$COMMANDS_DIR" ]; then
  echo "Directory $COMMANDS_DIR does not exist."
  exit 1
fi

# Copy each file in the commands directory to /bin and make it executable
for file in "$COMMANDS_DIR"/*; do
  if [ -f "$file" ]; then
    filename=$(basename "$file")
    cp "$file" /bin/"$filename"
    chmod +x /bin/"$filename"
    dos2unix /bin/"$filename" > /dev/null # Ensure command is in bash formatting
    echo "Installed $filename to /bin and made it executable."
  fi
done

echo "Setup completed."
