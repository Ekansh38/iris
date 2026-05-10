#!/usr/bin/env python3
"""
Iris — 20-20-20 Eye Break Timer
A macOS menu bar app to protect your eyes during long coding sessions.
"""

import subprocess
import rumps

# ── Config ────────────────────────────────────────────────────────────────────
WORK_SECONDS   = 20 * 60   # 20 minutes
BREAK_SECONDS  = 20        # 20 seconds
SNOOZE_SECONDS = 5 * 60    # 5 minutes
BREAK_SOUND    = "/System/Library/Sounds/Glass.aiff"
# ─────────────────────────────────────────────────────────────────────────────


def fmt(seconds: int) -> str:
    m, s = divmod(int(seconds), 60)
    return f"{m:02d}:{s:02d}"


class Iris(rumps.App):
    def __init__(self):
        super().__init__("👁", quit_button=None)

        self.remaining    = WORK_SECONDS
        self.in_break     = False
        self.paused       = False
        self.breaks_today = 0

        # Menu items
        self.status_item = rumps.MenuItem("Next break in 20:00")
        self.pause_item  = rumps.MenuItem("Pause", callback=self.toggle_pause)
        self.snooze_item = rumps.MenuItem("Snooze 5 min", callback=self.snooze)
        self.stats_item  = rumps.MenuItem("Today: 0 breaks")
        quit_item        = rumps.MenuItem("Quit Iris", callback=rumps.quit_application)

        self.menu = [
            self.status_item,
            None,
            self.pause_item,
            self.snooze_item,
            None,
            self.stats_item,
            None,
            quit_item,
        ]

        self._tick_timer = rumps.Timer(self._tick, 1)
        self._tick_timer.start()
        self._refresh_title()

    # ── Timer ─────────────────────────────────────────────────────────────────

    def _tick(self, _):
        if self.paused:
            return

        self.remaining -= 1

        if self.remaining <= 0:
            if self.in_break:
                self._end_break()
            else:
                self._start_break()

        self._refresh_title()
        self._refresh_menu()

    # ── Break lifecycle ───────────────────────────────────────────────────────

    def _start_break(self):
        self.in_break  = True
        self.remaining = BREAK_SECONDS

        subprocess.Popen(["afplay", BREAK_SOUND])
        rumps.notification(
            "Iris",
            "Eye break — look 20 ft away",
            "Blink 10–15 times while you're at it 👀",
        )

    def _end_break(self):
        self.in_break     = False
        self.remaining    = WORK_SECONDS
        self.breaks_today += 1

        # Voice cue — eyes are off screen so they need audio confirmation
        subprocess.Popen(["say", "-r", "170", "Break over. Good work."])

        label = "break" if self.breaks_today == 1 else "breaks"
        self.stats_item.title = f"Today: {self.breaks_today} {label} ✓"

    # ── Menu actions ──────────────────────────────────────────────────────────

    def toggle_pause(self, _):
        self.paused = not self.paused
        self.pause_item.title = "Resume" if self.paused else "Pause"
        self._refresh_title()

    def snooze(self, _):
        if not self.in_break:
            self.remaining += SNOOZE_SECONDS
            rumps.notification("Iris", "Snoozed 5 minutes", "Finish your thought 👍")

    # ── Display ───────────────────────────────────────────────────────────────

    def _refresh_title(self):
        if self.paused:
            self.title = "👁 ⏸"
        elif self.in_break:
            self.title = f"🟡 {fmt(self.remaining)}s"
        else:
            self.title = f"👁 {fmt(self.remaining)}"

    def _refresh_menu(self):
        if self.in_break:
            self.status_item.title = f"Break — look away for {fmt(self.remaining)}s"
        elif self.paused:
            self.status_item.title = "Paused"
        else:
            self.status_item.title = f"Next break in {fmt(self.remaining)}"


if __name__ == "__main__":
    Iris().run()
