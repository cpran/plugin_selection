include ../../plugin_testsimple/procedures/test_simple.proc

selection$ = preferencesDirectory$ - "con" +
  ... "/plugin_selection/scripts/"

@no_plan()

select all
baseline = numberOfSelected()

for i to 5
  sound[i] = Create Sound from formula: "sound" + string$(i),
    ... 1, 0, 1, 44100, "1/2 * sin(2*pi*377*x) + randomGauss(0,0.1)"
endfor
for i to 5
  nocheck plusObject: sound[i]
endfor

runScript: selection$ + "save_selection.praat"
@ok_formula: "numberOfSelected(""Table"")",
  ... "save selection creates table"

if !numberOfSelected("Table")
  @bail_out: "save selection did not create table"
endif

sounds = selected("Table")

select all
before_copying = numberOfSelected()

selectObject: sounds
runScript: selection$ + "restore_selection.praat"
@ok_formula: "numberOfSelected(""Sound"") = 5",
  ... "restored selection from table"

runScript: selection$ + "copy_selected.praat"
runScript: selection$ + "save_selection.praat"
copied = selected("Table")

select all
minusObject: copied
after_copying = numberOfSelected()

@ok_formula: "after_copying - before_copying = 5",
  ... "copied 5 objects"

nocheck selectObject: undefined
runScript: selection$ + "select_one_type.praat", "Sound", "no"
@ok_formula: "numberOfSelected(""Sound"") = 10",
  ... "selected all Sound objects"

select all
minusObject: sound[1]
runScript: selection$ + "select_one_type.praat", "Sound", "yes"
@ok_formula: "numberOfSelected(""Sound"") = 9",
  ... "refined selection to Sound"

selectObject: sound[1]
runScript: selection$ + "select_selected_type.praat"
@ok_formula: "numberOfSelected(""Sound"") = 10",
  ... "selected all objects of selected type"

minusObject: sound[1]
runScript: selection$ + "invert_selection.praat"
@ok_formula: "numberOfSelected(""Sound"") = 1",
  ... "inverted selection"

selectObject: sounds, copied
runScript: selection$ + "restore_selection.praat"
@ok_formula: "numberOfSelected(""Sound"") = 10",
  ... "restored multiple selection tables"
Remove

removeObject: sounds, copied

## Make sure no objects are left behind
select all
@ok_formula: "numberOfSelected() = baseline", "ensure clean up"

@done_testing()
