#!/usr/bin/env python3
"""
Convert Kitty session dump to Kitty session file for reloading.
"""

import json
import os
import sys


def env_to_str(env):
    """Convert an env dictionary to '--env key=value' format."""
    return " ".join(f"--env {key}={value}" for key, value in env.items())


def cmdline_to_str(cmdline):
    """Convert a cmdline list to a space-separated string."""
    return " ".join(cmdline)


def fg_proc_to_str(fg):
    """Convert foreground_processes to a launchable command."""
    cmd = cmdline_to_str(fg[0]["cmdline"])
    # Special case: Replace "kitty @ ls" with the default shell
    return os.getenv("SHELL") if cmd == "kitty @ ls" else cmd


def process_window(window):
    """Process individual window entry."""
    # Skip certain Kitty-specific commands or temporary commands
    cmdline = window["foreground_processes"][0]["cmdline"]
    executable = os.path.basename(cmdline[0])
    if executable in ["kitty", "kitten"]:
        return None
    if len(cmdline) > 1 and os.path.basename(cmdline[1]) == "dump-session.sh":
        return None

    launch_cmd = fg_proc_to_str(window["foreground_processes"])
    focus_cmd = "focus" if window.get("is_focused") else ""
    return f"launch {launch_cmd}\n{focus_cmd}".strip()


def convert(session):
    """Convert a Kitty session JSON into a session file format."""
    first_os_window = True

    for os_window in session:
        if not first_os_window:
            print("\nnew_os_window\n")
        first_os_window = False

        for tab in os_window["tabs"]:
            print("\n")
            print(f"new_tab {tab['title']}")
            print(f"layout {tab['layout']}")

            if tab["windows"]:
                print(f"cd {tab['windows'][0]['cwd']}")

            for window in tab["windows"]:
                window_commands = process_window(window)
                if window_commands:
                    print(window_commands)


def main():
    """Main entry point for reading stdin and processing the session."""
    try:
        session = json.load(sys.stdin)
        convert(session)
    except json.JSONDecodeError as e:
        print(f"Error: Invalid JSON input. {e}")
        sys.exit(1)
    except KeyError as e:
        print(f"Error: Missing expected key in session JSON. {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
