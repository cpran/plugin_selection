include ../procedures/selection.proc
include ../../plugin_tap/procedures/simple.proc

@plan(5)

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
pre = numberOfSelected()
@saveSelectionTable()
sounds = saveSelectionTable.table

removeObject: synth, sound, textgrid

## Create TextGrids
To TextGrid: "tier", ""
@saveSelectionTable()
textgrids = saveSelectionTable.table

selectObject: sounds, textgrids
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

@restoreSavedSelection(all)
Remove

## Remove all selection tables
@selectSelectionTables()
Remove

## Remove all object tables
@selectObjectTables()
@ok: numberOfSelected("Table") == 1, "select object tables"
Remove

@ok_selection()

@done_testing()
