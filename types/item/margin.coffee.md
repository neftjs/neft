Item.Margin
===========

	'use strict'

	expect = require 'expect'
	utils = require 'utils'

	{assert} = console

	module.exports = (Renderer, Impl, itemUtils) ->

*Margin* Margin
---------------

		class Margin
			@DATA =
				left: 0
				top: 0
				right: 0
				bottom: 0

			constructor: (item) ->
				expect(item).toBe.any Renderer.Item

				utils.defineProperty @, '_item', null, item

				data = Object.create Margin.DATA
				utils.defineProperty @, '_data', null, data

			createMarginProp = (type) ->
				itemUtils.defineProperty Margin::, type, null, null, (_super) -> (val) ->
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

			createMarginProp 'left'

*Float* Margin::top
--------------------

			createMarginProp 'top'

*Float* Margin::right
--------------------

			createMarginProp 'right'

*Float* Margin::bottom
--------------------

			createMarginProp 'bottom'