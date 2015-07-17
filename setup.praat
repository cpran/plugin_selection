# Setup script for selection plugin
#
# Find the latest version of this plugin at
# https://gitlab.com/cpran/plugin_selection
#
# Written by Jose Joaquín Atria
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
nocheck Add menu command: "Objects", "Praat", "selection", "CPrAN", 1, ""

nocheck Add menu command: "Objects", "Praat", "Copy selected objects...", "selection", 2, "scripts/copy_selected.praat"
nocheck Add menu command: "Objects", "Praat", "Sort selected objects...", "selection", 2, "scripts/sort_objects.praat"

# Object selection menu
Add menu command: "Objects", "Praat", "Select one type...",       "selection", 2, "scripts/select_one_type.praat"
Add menu command: "Objects", "Praat", "Select all of this type",  "selection", 2, "scripts/select_selected_type.praat"
Add menu command: "Objects", "Praat", "Invert selection",         "selection", 2, "scripts/invert_selection.praat"
Add menu command: "Objects", "Praat", "Save selection",           "selection", 2, "scripts/save_selection.praat"

## Dynamic commands

# Table commands
Add action command: "Table", 0, "", 0, "", 0, "Selection table -", "",                  0, ""
Add action command: "Table", 0, "", 0, "", 0, "Restore selection", "Selection table -", 1, "scripts/restore_selection.praat"
