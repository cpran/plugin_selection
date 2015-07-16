# Selection tools [![build badge][badge]][build]

The file [selection.proc][selection] defines a set of procedures to try to
make it easier to manage the selection of objects in Praat. It is an attempt at
providing some sort of informal API of sorts to save various selections, restore
them at will, modify them, etc.

[selection]: https://gitlab.com/cpran/plugin_selection/blob/master/procedures/selection.proc

## Usage

~~~~
include ../../plugin_selection/procedures/selection.proc
~~~~

## Overview

Praat does not allow for the creation of custom object types, so it was
necessary to generate some abstraction of a selection that could be represented
using the existing object types. A **selection table** is a object of type
`Table` that represents a given selection. The procedures provide ways to
generate them based on the existing selection, to create new ones procedurally,
and to make them either from subsets, or as combinations of existing tables.

A **selection table** is simply a `Table` that contains the following fields:

* `type`, holding the type of a given object as a string
* `name`, holding the name of a given object as a string
* `n`, a placeholder variable holding the value `1`
* `id`, holding the id number of the corresponding object

**Any** `Table` that contains _at least_ these columns will be considered a
**selection table**, and can be used with these procedures.

Almost every procedure here uses **selection tables** to manage the selection,
with two exceptions: [saveSelection()][saveselection] and
[restoreSelection()][restoreselection].

[saveselection]: https://gitlab.com/cpran/plugin_selection/wikis/home#saveselection
[restoreselection]: https://gitlab.com/cpran/plugin_selection/wikis/home#restoreselection

Below, all procedures are explained in an order that will hopefully make it
easier to learn how to use them.

Please see [the documentation](https://gitlab.com/cpran/plugin_selection/wikis/home)
for more detailed information on how to use these procedures.

## Requirements:

* [utils](https://gitlab.com/cpran/plugin_utils)

[badge]: https://ci.gitlab.com/projects/2841/status.png?ref=master
[build]: https://ci.gitlab.com/projects/2841
