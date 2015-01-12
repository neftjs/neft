Item.Margin
===========

	'use strict'

	expect = require 'expect'
	utils = require 'utils'

	{assert} = console

	module.exports = (Renderer, Impl, itemUtils) ->

		class Margin
			@__name__ = 'Margin'

			@DATA =
				left: 0
				top: 0
				right: 0
				bottom: 0

*Margin* Margin(*Renderer.Item* item)
-------------------------------------

			constructor: (item) ->
				expect(item).toBe.any Renderer.Item

				utils.defineProperty @, '_item', null, item

				data = Object.create Margin.DATA
				utils.defineProperty @, '_data', null, data

			createMarginProp = (type) ->
				itemUtils.defineProperty Margin::, type, null, null, (_super) -> (val) ->
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
				(@left + @top + @right + @bottom) / 4
