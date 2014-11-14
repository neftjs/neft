	'use strict'

	expect = require 'expect'
	utils = require 'utils'
	Dict = require 'dict'

	{assert} = console

	module.exports = (Renderer, Impl) ->

Margins
-------

*Anchors* object also provides a way to set *left*, *top*, *right* and *bottom* margins.

```coffeescript
Renderer.Rectangle.create
    id: 'rect1'
    ...

Renderer.Rectangle.create
    id: 'rect2'
    anchors:
        left: 'rect1.right'
        margin:
            left: 20
    ...
```

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

			createMarginProp 'left'
			createMarginProp 'top'
			createMarginProp 'right'
			createMarginProp 'bottom'