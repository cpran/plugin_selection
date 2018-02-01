include ../procedures/tables.proc
include ../../plugin_utils/procedures/try.proc
include ../../plugin_tap/procedures/simple.proc

@plan(17)

## Create test sounds
if praatVersion >= 6036
  synth_language$ = "English (Great Britain)"
  synth_voice$ = "Male1"
else
  synth_language$ = "English"
  synth_voice$ = "default"
endif

synth = Create SpeechSynthesizer: synth_language$, synth_voice$
To Sound: "This is some funky text", "yes"
sound = selected("Sound")
textgrid = selected("TextGrid")
Extract non-empty intervals: 3, "no"
for i to numberOfSelected()
  sound[i] = selected(i)
endfor
pre = numberOfSelected("Sound")
pre2 = pre + pre

removeObject: synth, sound, textgrid

@saveSelectionTable()
sounds = saveSelectionTable.table
@ok: numberOfSelected("Sound") == pre, "save selection table"

## Create TextGrids
To TextGrid: "tier", ""
for i to numberOfSelected()
  textgrid[i] = selected(i)
endfor

## Save TextGrid selection
@saveSelectionTable()
textgrids = saveSelectionTable.table
@ok: numberOfSelected("TextGrid") == pre, "save selection table twice"

for i to pre
  plusObject: sound[i]
endfor
@ok:  numberOfSelected("TextGrid") ==  pre and
  ... numberOfSelected("Sound")    ==  pre and
  ... numberOfSelected()           ==  pre2,
    ... "simple plus selection from existing selection"

## Swap between saved selections
@restoreSavedSelection(sounds)
@ok: numberOfSelected("TextGrid")  ==  0   and
 ... numberOfSelected("Sound")     ==  pre and
 ... numberOfSelected()            ==  pre,
 ... "restore saved selection"

## De-select saved selection
@minusSavedSelection(sounds)
@ok: numberOfSelected() == 0, "minus saved selection"

## Add saved selection to current selection
@plusSavedSelection(sounds)
@plusSavedSelection(textgrids)
@ok: numberOfSelected("TextGrid")  ==  pre and
 ... numberOfSelected("Sound")     ==  pre and
 ... numberOfSelected()            ==  pre2,
 ... "plus saved selections"

## Refine selection to specified type
@refineToTypes("Sound")
@ok: numberOfSelected("TextGrid")  == 0   and
 ... numberOfSelected("Sound")     == pre and
 ... numberOfSelected()            == pre,
 ... "refine to type"

## Select all objects of given type
@selectTypes("TextGrid")
@ok: numberOfSelected("TextGrid")  == pre and
 ... numberOfSelected("Sound")     == 0   and
 ... numberOfSelected()            == pre,
 ... "select type"

## Add saved selections together
selectObject: sounds,textgrids
all = Append

# Deselect multiple object types
@restoreSavedSelection(all)
@minusTypes("Sound TextGrid")
@ok: numberOfSelected("TextGrid")  == 0 and
 ... numberOfSelected("Sound")     == 0 and
 ... numberOfSelected()            == 0,
 ... "deselect multiple types"

# Refine selection to multiple object types
@restoreSavedSelection(all)
@refineToTypes("Sound TextGrid")
@ok: numberOfSelected("TextGrid")  ==  pre and
 ... numberOfSelected("Sound")     ==  pre and
 ... numberOfSelected("Pitch")     ==  0   and
 ... numberOfSelected()            ==  pre2,
 ... "refine to multiple types"

# Select only certain types
@clearSelection()
@selectTypes("Sound TextGrid")
@ok: numberOfSelected("TextGrid")  == pre and
 ... numberOfSelected("Sound")     == pre and
 ... numberOfSelected("Pitch")     == 0   and
 ... numberOfSelected()            == pre2,
 ... "select multiple types"

@restoreSavedSelection(all)
@ok: numberOfSelected("TextGrid")  == pre and
 ... numberOfSelected("Sound")     == pre and
 ... numberOfSelected()            == pre2,
 ... "restore all objects"

# Strict restore
@minusTypes("TextGrid")
Remove
@selectTypes("TextGrid")
call try
  ... selection.restore_nocheck = 0       \n
  ... include ../procedures/tables.proc   \n
  ... victim = selected(1)                \n
  ... @saveSelectionTable()               \n
  ... table = saveSelectionTable.table    \n
  ... removeObject: victim                \n
  ... nocheck selectObject: undefined     \n
  ... @restoreSavedSelection(table)       \n

@ok: try.catch,
  ... "strict restore with missing objects"

# Restore undefined instead of table
call try
  ... include ../procedures/tables.proc   \n
  ... @restoreSavedSelection(undefined)   \n

@ok: try.catch,
  ... "restore undefined table"

@restoreSavedSelection(all)
minusObject: selected(1)
Remove
@restoreSavedSelection(all)

# Restore non-table
call try
  ... include ../procedures/tables.proc   \n
  ... @restoreSavedSelection(selected())  \n

@ok: try.catch,
  ... "restore non table"

@restoreSavedSelection(all)
Remove

## Remove all selection tables
@selectSelectionTables()
@ok: numberOfSelected("Table") == 4, "select selection tables"
Remove

@ok_selection()

@done_testing()
