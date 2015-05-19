include ../procedures/selection.proc
include ../../plugin_testsimple/procedures/test_simple.proc
jja.debug = 0

@plan(18)

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
@ok_formula: "numberOfSelected(""Sound"") = 0", "clear selection"

## Save Sound selection
for i from 1 to 5
  plusObject: sound[i]
endfor

@saveSelectionTable()
sounds = saveSelectionTable.table
@ok_formula: "numberOfSelected(""Sound"") = 5", "save selection table"

## Create TextGrids
To TextGrid: "tier", ""

## Save TextGrid selection
@saveSelectionTable()
textgrids = saveSelectionTable.table
@ok_formula: "numberOfSelected(""TextGrid"") = 5", "save selection table twice"

## Swap between saved selections
@restoreSavedSelection(sounds)
@ok: if numberOfSelected("TextGrid") =  0 and
    ... numberOfSelected("Sound")    =  5 and
    ... numberOfSelected()           =  5 then 1 else 0 fi,
    ... "restore saved selection"

## De-select saved selection
@minusSavedSelection(sounds)
@ok_formula: "numberOfSelected() = 0", "minus saved selection" 

## Add saved selection to current selection
@plusSavedSelection(sounds)
@plusSavedSelection(textgrids)
@ok: if numberOfSelected("TextGrid") =  5 and
    ... numberOfSelected("Sound")    =  5 and
    ... numberOfSelected()           = 10 then 1 else 0 fi,
    ... "plus saved selections"

## Refine selection to specified type
@refineToType("Sound")
@ok: if numberOfSelected("TextGrid") = 0 and
    ... numberOfSelected("Sound")    = 5 and
    ... numberOfSelected()           = 5 then 1 else 0 fi,
    ... "refine to type"

## Select all objects of given type
@selectType("TextGrid")
@ok: if numberOfSelected("TextGrid") = 5 and
    ... numberOfSelected("Sound")    = 0 and
    ... numberOfSelected()           = 5 then 1 else 0 fi,
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
@ok_formula: "countObjects.n = 5", "count existing objects"
@countObjects(objects, "Pitch")
@ok_formula: "countObjects.n = 0", "count non-existing objects"

# Deselect multiple object types
@restoreSavedSelection(all)
@deselectTypes("Sound TextGrid")
@ok: if numberOfSelected("TextGrid") = 0 and
    ... numberOfSelected("Sound")    = 0 and
    ... numberOfSelected()           = 0 then 1 else 0 fi,
    ... "deselect multiple types"

# Refine selection to multiple object types
@restoreSavedSelection(all)
@refineToTypes("Sound TextGrid")
@ok: if numberOfSelected("TextGrid") =  5 and
    ... numberOfSelected("Sound")    =  5 and
    ... numberOfSelected("Pitch")    =  0 and
    ... numberOfSelected()           = 10 then 1 else 0 fi,
    ... "refine to multiple types"

# Select only certain types
@clearSelection()
@selectTypes("Sound TextGrid")
@ok: if numberOfSelected("TextGrid") =  5 and
    ... numberOfSelected("Sound")    =  5 and
    ... numberOfSelected("Pitch")    =  0 and
    ... numberOfSelected()           = 10 then 1 else 0 fi,
    ... "select multiple types"

@restoreSavedSelection(all)
@ok: if numberOfSelected("TextGrid") =  5 and
    ... numberOfSelected("Sound")    =  5 and
    ... numberOfSelected()           = 10 then 1 else 0 fi,
    ... "restore all objects"
Remove

## Remove all selection tables
@selectSelectionTables()
@ok_formula: "numberOfSelected(""Table"") = 3", "select selection tables"
Remove

## Remove all object tables
@selectObjectTables()
@ok_formula: "numberOfSelected(""Table"") = 1", "select object tables"
Remove

## Make sure no objects are left behind
select all
@ok_formula: "numberOfSelected() = baseline", "ensure clean up"

@done_testing()
