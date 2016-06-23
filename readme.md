# Selection tools [![build badge][badge]][build]

The files in this plugin define a set of procedures to make it easier to manage 
the selection of objects in Praat. It is an attempt at providing what was
considered to be a missing part of the API, to save various selections, restore
them at will, modify them, etc.

## Usage

~~~~
# Includes all procedures
include ../../plugin_selection/procedures/selection.proc

# You can also opt just for the most basic ones
# which do not use selection tables
include ../../plugin_selection/procedures/tiny.proc

# Or just for those using tables
# (which are also the most useful)
include ../../plugin_selection/procedures/tables.proc

# Or include the procedures for selection checking
include ../../plugin_selection/procedures/objects.proc
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

Please see [the documentation](http://cpran.net/docs/plugins/selection)
for more detailed information on how to use these procedures.

## Requirements:

* [utils](http://cpran.net/plugins/utils)

[badge]: https://ci.gitlab.com/projects/2841/status.png?ref=master
[build]: https://ci.gitlab.com/projects/2841
