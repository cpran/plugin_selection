# Copy multiple selected objects
#
# Praat's built-in "Copy" command only works for a single selected object.
# Thinking that this is an unnecessary limitation, this script allows one to
# copy whole sets of objects at once.
#
# This script is part of the selection CPrAN plugin for Praat.
# The latest version is available through CPrAN or at
# <http://cpran.net/plugins/selection>
#
# The selection plugin is free software: you can redistribute it
# and/or modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation, either
# version 3 of the License, or (at your option) any later version.
#
# The selection plugin is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty
# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with selection. If not, see <http://www.gnu.org/licenses/>.
#
# Copyright 2014, 2015 Jose Joaquin Atria

include ../procedures/selection.proc

@saveSelection()
@createEmptySelectionTable()
new = createEmptySelectionTable.table

for i to saveSelection.n
  selectObject: saveSelection.id[i]
  type$ = extractWord$(selected$(), "")
  name$ = selected$(type$)
  Copy: name$
  @addToSelectionTable(new, selected())
endfor

@restoreSavedSelection(new)
removeObject: new
