View Structure
==============

Goals
-----

Provide easy to use wrapper for `DOM` and other engines to parse `HTML`.

	'use strict'

	assert = require 'assert'

	IMPLS =
		jsdom: unless window? then require './impls/jsdom/index.coffee'
		dom: if window? then require './impls/dom/index.coffee'

	module.exports = (impl) ->

		impl = IMPLS[impl]
		assert typeof impl is 'object'

		modules = {}

		modules.Element = require('./Element.coffee.md') impl.Element, modules
		modules.Attrs = require('./Attrs.coffee.md') impl.Attrs, modules

		modules.Element