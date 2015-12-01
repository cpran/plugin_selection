include ../procedures/selection.proc
include ../../plugin_testsimple/procedures/test_simple.proc

@plan(23)

select all
baseline = numberOfSelected()

## Create test sounds
name$ = "sound"
sound[1] = Create Sound as pure tone: name$,
  ... 1, 0, 0.4, 44100, 220, 0.2, 0.01, 0.01
for i from 2 to 5
  sound[i] = Copy: name$
endfor

## Clear selection
@clearSelection()
@ok: numberOfSelected("Sound") == 0, "clear selection"

## Save Sound selection
for i from 1 to 5
  plusObject: sound[i]
endfor

# Simple save selection
pre = numberOfSelected("Sound")
@saveSelection()
post = numberOfSelected("Sound")
@ok: pre == post, "simple save selection does not change selection"

@clearSelection()

# Simple restore selection
@restoreSelection()
post = numberOfSelected("Sound")
@ok: numberOfSelected("Sound") == 5, "simple restore selection"

# Simple minus selection
@minusSelection()
@ok: numberOfSelected("Sound") == 0, "simple minus selection"

# Simple plus selection
@plusSelection()
@ok: numberOfSelected("Sound") == 5, "simple plus selection from blank"

@saveSelectionTable()
sounds = saveSelectionTable.table
@ok: numberOfSelected("Sound") == 5, "save selection table"

## Create TextGrids
To TextGrid: "tier", ""

## Save TextGrid selection
@saveSelectionTable()
textgrids = saveSelectionTable.table
@ok: numberOfSelected("TextGrid") == 5, "save selection table twice"

@plusSelection()
@ok:  numberOfSelected("TextGrid") ==  5 and
  ... numberOfSelected("Sound")    ==  5 and
  ... numberOfSelected()           == 10,
    ... "simple plus selection from existing selection"

## Swap between saved selections
@restoreSavedSelection(sounds)
@ok: numberOfSelected("TextGrid")  ==  0 and
 ... numberOfSelected("Sound")     ==  5 and
 ... numberOfSelected()            ==  5,
 ... "restore saved selection"

## De-select saved selection
@minusSavedSelection(sounds)
@ok: numberOfSelected() == 0, "minus saved selection"

## Add saved selection to current selection
@plusSavedSelection(sounds)
@plusSavedSelection(textgrids)
@ok: numberOfSelected("TextGrid")  ==  5 and
 ... numberOfSelected("Sound")     ==  5 and
 ... numberOfSelected()            == 10,
 ... "plus saved selections"

## Refine selection to specified type
@refineToTypes("Sound")
@ok: numberOfSelected("TextGrid")  == 0 and
 ... numberOfSelected("Sound")     == 5 and
 ... numberOfSelected()            == 5,
 ... "refine to type"

## Select all objects of given type
@selectTypes("TextGrid")
@ok: numberOfSelected("TextGrid")  == 5 and
 ... numberOfSelected("Sound")     == 0 and
 ... numberOfSelected()            == 5,
 ... "select type"

## Add saved selections together
selectObject: sounds,textgrids
all = Append

## Test object tables
@checkSelectionTable(all)
objects = checkSelectionTable.table
@ok: checkSelectionTable.return, "check selection table"

## Count object types
@countObjects(objects, "Sound")
@ok: countObjects.n == 5, "count existing objects"
@countObjects(objects, "Pitch")
@ok: countObjects.n == 0, "count non-existing objects"

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
@ok: numberOfSelected("TextGrid")  ==  5 and
 ... numberOfSelected("Sound")     ==  5 and
 ... numberOfSelected("Pitch")     ==  0 and
 ... numberOfSelected()            == 10,
 ... "refine to multiple types"

# Select only certain types
@clearSelection()
@selectTypes("Sound TextGrid")
@ok: numberOfSelected("TextGrid")  ==  5 and
 ... numberOfSelected("Sound")     ==  5 and
 ... numberOfSelected("Pitch")     ==  0 and
 ... numberOfSelected()            == 10,
 ... "select multiple types"

@restoreSavedSelection(all)
@ok: numberOfSelected("TextGrid")  ==  5 and
 ... numberOfSelected("Sound")     ==  5 and
 ... numberOfSelected()            == 10,
 ... "restore all objects"
Remove

## Remove all selection tables
@selectSelectionTables()
@ok: numberOfSelected("Table") == 3, "select selection tables"
Remove

## Remove all object tables
@selectObjectTables()
@ok: numberOfSelected("Table") == 1, "select object tables"
Remove

## Make sure no objects are left behind
select all
@ok: numberOfSelected() == baseline, "ensure clean up"

@done_testing()
