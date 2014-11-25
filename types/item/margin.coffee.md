Item.Margin
===========

	'use strict'

	expect = require 'expect'
	utils = require 'utils'
	Dict = require 'dict'

	{assert} = console

	module.exports = (Renderer, Impl) ->

*Margin* Margin
---------------

**Extends:** `Dict`

		class Margin extends Dict
			@DATA =
				left: 0
				top: 0
				right: 0
				bottom: 0

			constructor: (item) ->
				expect(item).toBe.any Renderer.Item

				utils.defineProperty @, '_item', null, item

				super Object.create Margin.DATA

			createMarginProp = (type) ->
				Dict.defineProperty Margin::, type

				utils.defineProperty Margin::, type, utils.ENUMERABLE, utils.lookupGetter(Margin::, type)
				, do (_super = utils.lookupSetter Margin::, type) -> (val) ->
					`//<development>`
					id = @_item.__hash__
					assert typeof val is 'number' and isFinite(val)
					, "(##{id}).margin.#{type} expects a finite number; `#{val}` given"
					`//</development>`

					oldVal = @_data[type]
					if oldVal isnt val
						_super.call @, val
						@_item[Dict.getPropertySignalName 'margin']? @
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