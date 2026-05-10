#!/bin/bash
# Installs Iris to ~/.iris/ and registers it as a login item.
# Run this once from the project folder. After that, Iris.app and login auto-start both work.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALL_DIR="$HOME/.iris"
VENV="$INSTALL_DIR/venv"
PLIST="$HOME/Library/LaunchAgents/com.iris.eyetimer.plist"

echo "Installing Iris..."

# Copy script to home dir (away from TCC-restricted Desktop)
mkdir -p "$INSTALL_DIR"
cp "$SCRIPT_DIR/iris.py" "$INSTALL_DIR/iris.py"

# Set up venv with rumps
if [ ! -f "$VENV/bin/python3" ]; then
  python3 -m venv "$VENV"
  "$VENV/bin/pip" install -q rumps
  echo "  Python environment ready."
fi

# LaunchAgent: auto-start at login
mkdir -p "$HOME/Library/LaunchAgents"
cat > "$PLIST" << PLIST_EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.iris.eyetimer</string>
    <key>ProgramArguments</key>
    <array>
        <string>$VENV/bin/python3</string>
        <string>$INSTALL_DIR/iris.py</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
PLIST_EOF

# Start it now
launchctl unload "$PLIST" 2>/dev/null || true
launchctl load "$PLIST"

echo ""
echo "Done. Iris is running and will start automatically at login."
echo "To uninstall: launchctl unload $PLIST && rm -rf $INSTALL_DIR $PLIST"
