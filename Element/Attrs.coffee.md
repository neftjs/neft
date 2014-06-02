VS Attrs
========

	'use strict'

	[expect] = ['expect'].map require

	{isArray} = Array

*class* Attrs
-------------

	module.exports = (impl, modules) -> class Attrs

		{Element} = modules

		@__name__ = 'Attrs'
		@__path__ = 'File.Element.modules.Attrs'

### Constructor

		constructor: (@_element) ->

			expect(_element).toBe.any Element

### Properties

#### *Element* _element

		_element: null

### Methods

#### item()

Get specified attribute name and value based on a position.
If no target is specified, new array with attribute name and value will be returned.

		item: (i, target=[]) ->

			expect(target).toBe.array()

			target[0] = undefined
			target[1] = undefined

			impl.getItem.call @, i, target
			target

#### get()

Get attribute value based on name.

		get: (name) ->

			expect(name).toBe.truthy().string()

			impl.get.call @, name

#### set()

Change attribute value based on name.
Set value as `undefined` to remove attribute.

		set: (name, value) ->

			expect(name).toBe.truthy().string()

			impl.set.call @, name, value