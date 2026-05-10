#!/bin/bash
# Run Iris — uses the venv Python which has rumps installed.

cd "$(dirname "$0")"

VENV_PYTHON="$(dirname "$0")/venv/bin/python3"

if [ ! -f "$VENV_PYTHON" ]; then
  echo "Setting up venv..."
  python3 -m venv venv
  venv/bin/pip install -r requirements.txt
fi

exec "$VENV_PYTHON" iris.py
