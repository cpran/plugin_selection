# Selects objects by type
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
# Copyright 2015 Jose Joaquin Atria

include ../../plugin_utils/procedures/utils.proc
include ../../plugin_selection/procedures/selection.proc

form Select types...
  word Types Sound TextGrid
  boolean Refine_current_selection yes
  comment You can specify multiple types separated by spaces
endform

@split: " ", types$
for i to split.length
  @_IsValidType: split.return$[i]
  if !'_IsValidType.return'
    exitScript: split.return$[i], " is not a readable object type"
  endif
endfor

if refine_current_selection
  @refineToTypes: types$
else
  @selectTypes: types$
endif
