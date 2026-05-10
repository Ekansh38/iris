# Iris

A macOS menu bar app for the **20-20-20 rule**, the simplest habit to protect your eyes during long coding sessions.

> Vibe-coded with Claude.

---

## What is the 20-20-20 rule?

Every **20 minutes**, look at something **20 feet away** for **20 seconds**.

This gives your ciliary muscle (the one that controls your lens focus) a chance to fully relax. Without breaks, it stays contracted for hours, causing eye strain, headaches, and over time, can contribute to myopia progression.

---

## Features

- **Menu bar countdown** -- always visible, never in your way (`👁 18:42`)
- **Soft chime** when break starts -- so you know to look away
- **Bell when break ends** -- heard while your eyes are off screen
- **Snooze 5 min** -- for when you're mid-thought and need to finish
- **Pause / Resume** -- for meetings, lunch, stepping away
- **Daily break counter** -- simple streak to keep you honest
- No popups. No dialogs. Nothing that steals focus.

---

## Install

Run this once from the project folder:

```bash
./install.sh
```

This will:
- Install `iris.py` and its dependencies to `~/.iris/`
- Register a Login Item so Iris starts automatically every time you log in
- Start Iris immediately

After that, `Iris.app` is also available as a double-clickable launcher.

**Optional:** Move `Iris.app` to your `/Applications` folder for easy access from Spotlight and the Dock.

---

## Menu

```
👁 14:23
-----------------
Next break in 14:23
-----------------
Pause
Snooze 5 min
-----------------
Today: 6 breaks
-----------------
Quit Iris
```

---

## Config

Edit the constants at the top of `iris.py`:

```python
WORK_SECONDS   = 20 * 60   # how long between breaks
BREAK_SECONDS  = 20        # how long each break lasts
SNOOZE_SECONDS = 5 * 60    # snooze duration
```

Then re-run `./install.sh` to apply changes.

---

## Uninstall

```bash
launchctl unload ~/Library/LaunchAgents/com.iris.eyetimer.plist
rm -rf ~/.iris ~/Library/LaunchAgents/com.iris.eyetimer.plist
```

---

## Requirements

- macOS
- Python 3 (Homebrew recommended)
