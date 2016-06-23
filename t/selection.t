include ../procedures/selection.proc
include ../../plugin_tap/procedures/simple.proc

@plan(4)

## Create test sounds
synth = Create SpeechSynthesizer: "English", "default"
To Sound: "This is some funky text", "yes"
sound = selected("Sound")
textgrid = selected("TextGrid")
Extract non-empty intervals: 3, "no"

removeObject: synth, sound, textgrid

@saveSelection()
@ok: saveSelection.n,
  ... "loaded tiny procedures"

@saveSelectionTable()
table = saveSelectionTable.table
@ok: saveSelection.n,
  ... "loaded table procedures"

@checkSelectionTable(table)
objects = checkSelectionTable.table
@ok: checkSelectionTable.return,
  ... "loaded object procedures"

@selectSelectionTables()
@plusSelection()
Remove

@selectObjectTables()
Remove

@ok_selection()

@done_testing()
