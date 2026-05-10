# 👁 Iris

A macOS menu bar app for the **20-20-20 rule** — the simplest habit to protect your eyes during long coding sessions.

> Vibe-coded with Claude.

---

## What is the 20-20-20 rule?

Every **20 minutes**, look at something **20 feet away** for **20 seconds**.

This gives your ciliary muscle (the one that controls your lens focus) a chance to fully relax. Without breaks, it stays contracted for hours — causing eye strain, headaches, and over time, can contribute to myopia progression.

---

## Features

- **Menu bar countdown** — always visible, never in your way (`👁 18:42`)
- **Soft chime** when break starts — so you know to look away
- **Bell when break ends** — heard while your eyes are off screen
- **Snooze 5 min** — for when you're mid-thought and need to finish
- **Pause / Resume** — for meetings, lunch, stepping away
- **Daily break counter** — simple streak to keep you honest
- No popups. No dialogs. Nothing that steals focus.

---

## Install

```bash
pip3 install rumps
```

---

## Launch as an app (no Terminal needed)

The repo includes `Iris.app` — a native macOS app bundle you can double-click like any other app.

**First time only:** macOS will block it because it's unsigned. Right-click `Iris.app` → **Open** → **Open** to bypass this once. After that, double-click works normally.

**Optional — move to Applications:**

Drag `Iris.app` into your `/Applications` folder so it lives alongside your other apps and is easy to find from Spotlight.

**To launch at login:**
1. Open **System Settings → General → Login Items**
2. Click **+** under "Open at Login"
3. Select `Iris.app` (wherever you placed it)

Iris will start silently in the menu bar every time you log in.

---

## Run from Terminal

```bash
./run.sh
```

Or directly:

```bash
python3 iris.py
```

---

## Menu

```
👁 14:23
─────────────────
Next break in 14:23
─────────────────
Pause
Snooze 5 min
─────────────────
Today: 6 breaks ✓
─────────────────
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

---

## Requirements

- macOS (uses `afplay` — built in)
- Python 3
- [`rumps`](https://github.com/jaredks/rumps)
