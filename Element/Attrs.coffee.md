VS Attrs
========

	'use strict'

	isArray = Array.isArray

	assert = require 'assert'

*class* Attrs
-------------

	module.exports = (impl, modules) -> class Attrs

		{Element} = modules

### Constructor

		constructor: (@_element) ->

			assert _element instanceof Element

### Properties

#### *Element* _element

		_element: null

### Methods

#### item()

Get specified attribute name and value based on a position.
If no target is specified, new array with attribute name and value will be returned.

		item: (i, target=[]) ->

			assert isArray target

			target[0] = undefined
			target[1] = undefined

			impl.getItem.call @, i, target
			target

#### get()

Get attribute value based on name.

		get: (name) ->

			assert name and typeof name is 'string'

			impl.get.call @, name

#### set()

Change attribute value based on name.
Set value as `undefined` to remove attribute.

		set: (name, value) ->

			value += '' unless typeof value is 'undefined'

			assert name and typeof name is 'string'

			impl.set.call @, name, value