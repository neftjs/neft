Item/Custom properties @extension
======================

#### Create item custom property @snippet

```
Item {
  id: main
  property $.currentLife: 0.8

  Text {
  	text: "Life: " + main.$.currentLife
  }  
}
```

	'use strict'

	assert = require 'assert'

	module.exports = (Renderer, Impl, itemUtils, Item) ->

*Item* Item()
-------------

Item::createProperty(*String* name)
-----------------------------------

		Item::createProperty = (name) ->
			assert.isString name
			assert.notLengthOf name, 0

			@$ ?= new itemUtils.MutableDeepObject @

			return if @$.hasOwnProperty(name)

			itemUtils.defineProperty
				object: @$
				name: name

			@$["_#{name}"] = undefined

			@$._properties ?= []
			@$._properties.push name

			return

		Item::clone = do (_super = Item::clone) -> ->
			clone = _super.call @
			if @$ and @$._properties
				for prop in @$._properties
					clone.createProperty prop
					clone.$[prop] = @$[prop]
			clone