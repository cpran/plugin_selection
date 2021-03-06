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

# Base menu
nocheck Add menu command: "Objects", "Praat", "selection", "CPrAN", 1, ""

nocheck Add menu command: "Objects", "Praat", "Copy selected objects...", "selection", 2, "scripts/copy_selected.praat"
nocheck Add menu command: "Objects", "Praat", "Sort selected objects...", "selection", 2, "scripts/sort_objects.praat"

# Object selection menu
Add menu command: "Objects", "Praat", "Select per type...",          "selection", 2, "scripts/select_types.praat"
Add menu command: "Objects", "Praat", "Select types from selection", "selection", 2, "scripts/select_selected_types.praat"
Add menu command: "Objects", "Praat", "Invert selection",            "selection", 2, "scripts/invert_selection.praat"
Add menu command: "Objects", "Praat", "Save selection",              "selection", 2, "scripts/save_selection.praat"

## Dynamic commands

# Table commands
Add action command: "Table", 0, "", 0, "", 0, "Selection table -", "",                  0, ""
Add action command: "Table", 0, "", 0, "", 0, "Restore selection", "Selection table -", 1, "scripts/restore_selection.praat"
