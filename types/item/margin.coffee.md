Item.Margin
===========

	'use strict'

	expect = require 'expect'
	utils = require 'utils'

	{assert} = console

	module.exports = (Renderer, Impl, itemUtils) ->

		class Margin extends itemUtils.DeepObject
			@__name__ = 'Margin'

			itemUtils.initConstructor @,
				data:
					left: 0
					top: 0
					right: 0
					bottom: 0

*Margin* Margin(*Renderer.Item* item)
-------------------------------------

			createMarginProp = (type) ->
				setter = (_super) -> (val) ->
					true;
					`//<development>`
					id = @_item.__hash__
					assert typeof val is 'number' and isFinite(val)
					, "(##{id}).margin.#{type} expects a finite number; `#{val}` given"
					`//</development>`

					oldVal = @_data[type]
					if oldVal isnt val
						_super.call @, val
						@_item.marginChanged? @
						Impl.setItemMargin.call @_item, type, val

				itemUtils.defineProperty
					constructor: Margin
					name: type
					namespace: 'margin'
					setter: setter

*Float* Margin::left
--------------------

### *Signal* Margin::leftChanged(*Float* oldValue)

			createMarginProp 'left'

*Float* Margin::top
-------------------

### *Signal* Margin::topChanged(*Float* oldValue)

			createMarginProp 'top'

*Float* Margin::right
---------------------

### *Signal* Margin::rightChanged(*Float* oldValue)

			createMarginProp 'right'

*Float* Margin::bottom
----------------------

### *Signal* Margin::bottomChanged(*Float* oldValue)

			createMarginProp 'bottom'

*Float* Margin::valueOf()
--------------------------

			valueOf: ->
				if @left is @top and @top is @right and @right is @bottom
					@left
				else
					throw new Error "margin values are different"
