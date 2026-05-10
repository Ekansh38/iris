#!/bin/bash
# Run Iris — installs dependencies if needed, then launches the menu bar app.

cd "$(dirname "$0")"

if ! python3 -c "import rumps" 2>/dev/null; then
  echo "Installing dependencies..."
  pip3 install -r requirements.txt
fi

python3 iris.py
