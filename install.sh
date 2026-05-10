#!/bin/bash
# Installs Iris to ~/.iris/ and launches it.
# Run once from the project folder, then use Iris.app to launch anytime.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALL_DIR="$HOME/.iris"
VENV="$INSTALL_DIR/venv"

echo "Installing Iris..."

# Copy script away from Desktop (macOS TCC restricts app access there)
mkdir -p "$INSTALL_DIR"
cp "$SCRIPT_DIR/iris.py" "$INSTALL_DIR/iris.py"

# Set up venv with rumps
if [ ! -f "$VENV/bin/python3" ]; then
  python3 -m venv "$VENV"
fi
"$VENV/bin/pip" install -q rumps
echo "  Python environment ready."

# Remove any old LaunchAgent if present
PLIST="$HOME/Library/LaunchAgents/com.iris.eyetimer.plist"
if [ -f "$PLIST" ]; then
  launchctl unload "$PLIST" 2>/dev/null || true
  rm -f "$PLIST"
  echo "  Removed old LaunchAgent."
fi

echo ""
echo "Done. Launching Iris now..."
open "$SCRIPT_DIR/Iris.app"

echo ""
echo "To launch Iris anytime: double-click Iris.app or search in Spotlight."
echo "To start at login: System Settings > General > Login Items > add Iris.app"
echo "To uninstall: rm -rf ~/.iris"
