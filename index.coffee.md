View
====

Module to parse `HTML` with predefined tools.

Features
--------

### Elements abstract

All defned `HTML` elements are parsed and saved as `Element` object.
Learn more in `Element/index.coffee.md` file.

### Clearing

Input is automatically cleared:
1. Comments are removed.
2. Tabs and unnecessary spaces are removed.

### Units

`Unit` is separated part of code. It can be placed using `Elem`.
Learn more in `unit.coffee.md` and `elem.coffee.md` files.

### Including

One file can include other files using `link` tag.

	'use strict'

	module.exports = require './file.coffee.md'