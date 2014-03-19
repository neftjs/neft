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

	ELEMENT_IMPL = if window? then 'dom' else 'htmlparser'

	File = require './file.coffee.md'

	File.Element = require('./Element/index.coffee.md') ELEMENT_IMPL
	File.Unit = require('./unit.coffee.md') File
	File.Elem = require('./elem.coffee.md') File


	module.exports = File