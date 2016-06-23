include ../procedures/tiny.proc
include ../../plugin_tap/procedures/simple.proc
include ../../plugin_utils/procedures/try.proc

@plan(14)

# Restore before saving
call try
  ... include ../procedures/tiny.proc     \n
  ... @restoreSelection()                 \n

@ok: try.catch,
  ... "restore before saving"

# Plus before saving
call try
  ... include ../procedures/tiny.proc     \n
  ... @plusSelection()                    \n

@ok: try.catch,
  ... "plus before saving"

# Minus before saving
call try
  ... include ../procedures/tiny.proc     \n
  ... @minusSelection()                   \n

@ok: try.catch,
  ... "minus before saving"

## Create test sounds
synth = Create SpeechSynthesizer: "English", "default"
To Sound: "This is some funky text", "yes"
sound = selected("Sound")
textgrid = selected("TextGrid")
Extract non-empty intervals: 3, "no"
for i to numberOfSelected()
  sound[i] = selected(i)
endfor

# Save selection
pre = numberOfSelected("Sound")
@saveSelection()
post = numberOfSelected("Sound")
@ok: pre == post, "saving selection does not change selection"

nocheck selectObject: undefined

# Restore selection
@restoreSelection()
@ok: pre == numberOfSelected("Sound"), "restore selection"

# Minus selection
plusObject: sound
@minusSelection()
@ok: numberOfSelected("Sound") == 1, "minus selection"

# Plus selection
@plusSelection()
@ok: numberOfSelected("Sound") == pre + 1, "plus selection"

# Minus selection to empty
minusObject: sound
@minusSelection()
@ok: !numberOfSelected(), "minus selection to empty"

# Plus selection from empty
nocheck selectObject: undefined
@plusSelection()
@ok: numberOfSelected("Sound") == pre, "plus selection from empty"

# Plus selection with missing objects
nocheck selectObject: undefined
removeObject: saveSelection.id[1]
@plusSelection()
@ok: numberOfSelected("Sound") == pre - 1,
  ... "plus selection with missing objects"

# Restore selection with missing objects
nocheck selectObject: undefined
@restoreSelection()
@ok: numberOfSelected("Sound") == pre - 1,
  ... "restore selection with missing objects"

# Strict restore
@restoreSelection()
call try
  ... selection.restore_nocheck = 0       \n
  ... include ../procedures/tiny.proc     \n
  ... @saveSelection()                    \n
  ... removeObject: saveSelection.id[1]   \n
  ... @restoreSelection()                 \n

@ok: try.catch,
  ... "strict restore with missing objects"

# Strict plus
@restoreSelection()
call try
  ... selection.restore_nocheck = 0       \n
  ... include ../procedures/tiny.proc     \n
  ... @saveSelection()                    \n
  ... removeObject: saveSelection.id[1]   \n
  ... @plusSelection()                    \n

@ok: try.catch,
  ... "strict plus with missing objects"

plusObject: synth, sound, textgrid
Remove

@ok_selection()

@done_testing()
