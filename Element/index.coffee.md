View Structure
==============

Goals
-----

Provide easy to use wrapper for `DOM` and other engines to parse `HTML`.

	'use strict'

	[utils] = ['utils'].map require

	{assert} = console

	impl = switch true
		when utils.isNode
			require './impls/htmlparser/index.coffee'

	# TODO
	# remove dom impl

	modules = {}

	modules.Element = require('./Element.coffee.md') impl?.Element, modules
	modules.Attrs = require('./Attrs.coffee.md') impl?.Attrs, modules

	modules.Element

	module.exports = modules.Element