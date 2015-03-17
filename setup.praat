# Setup script for selection plugin
#
# Find the latest version of this plugin at
# https://gitlab.com/cpran/plugin_selection
#
# Written by Jose J. Atria (18 November 2011)
# Latest revision: April 4, 2014
#
# This script is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# A copy of the GNU General Public License is available at
# <http://www.gnu.org/licenses/>.

## Static commands:

# Uncomment next line to run tests at startup
# runScript: "run_tests.praat"

# Base menu
Add menu command: "Objects", "Praat", "CPrAN",                    "",            0, ""
Add menu command: "Objects", "Praat", "Selection",                "CPrAN",       1, ""

Add menu command: "Objects", "Praat", "Copy selected objects...", "Selection",   2, "scripts/copy_selected.praat"
Add menu command: "Objects", "Praat", "Sort selected objects...", "Selection",   2, "scripts/sort_objects.praat"

# Object selection menu
Add menu command: "Objects", "Praat", "Select one type...",       "Selection -", 2, "scripts/select_one_type.praat"
Add menu command: "Objects", "Praat", "Invert selection",         "Selection -", 2, "scripts/invert_selection.praat"
Add menu command: "Objects", "Praat", "Save selection",           "Selection -", 2, "scripts/save_selection.praat"

## Dynamic commands

# Table commands
Add action command: "Table", 0, "", 0, "", 0, "Selection table -", "",                  0, ""
Add action command: "Table", 0, "", 0, "", 0, "Restore selection", "Selection table -", 1, "scripts/restore_selection.praat"
