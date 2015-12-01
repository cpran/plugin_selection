# Selects one single type of object
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

form Select one type...
  word Type Sound
  boolean Refine_current_selection yes
endform

appendInfoLine: "W: ""select_one_type"" is deprecated. Use ""select_types"" instead"

runScript: "select_types.praat", type$, refine_current_selection
