View Structure
==============

Goals
-----

Provide easy to use wrapper for `DOM` and other engines to parse `HTML`.

	'use strict'

	[utils] = ['utils'].map require

	impl = require './impls/htmlparser/index.coffee'

	modules = {}

	modules.Element = require('./Element.coffee.md') impl?.Element, modules
	modules.Attrs = require('./Attrs.coffee.md') impl?.Attrs, modules

	modules.Element

	module.exports = modules.Element