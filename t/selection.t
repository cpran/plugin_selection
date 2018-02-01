include ../procedures/selection.proc
include ../../plugin_tap/procedures/more.proc

@plan(4)

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

removeObject: synth, sound, textgrid

@saveSelection()
@cmp_ok: saveSelection.n, "==", 5,
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
