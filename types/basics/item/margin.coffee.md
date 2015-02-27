Positioning/Margins @txt
========================

	'use strict'

	expect = require 'expect'
	utils = require 'utils'

	{assert} = console

	module.exports = (Renderer, Impl, itemUtils, Item) ->

		class Margin extends itemUtils.DeepObject
			@__name__ = 'Margin'

			constructor: ->
				super()

*Margin* Margin()
-----------------

Margins are used to move an item in **anchors** and in positioning items
([Renderer.Column][], [Renderer.Row][] and [Renderer.Grid][]).

```style
Column {
  Rectangle { color: 'red'; width: 50; height: 50; }
  Rectangle { color: 'yellow'; width: 50; height: 50; margin.top: 20; }
  Rectangle { color: 'green'; width: 50; height: 50; }
}
```

```style
Rectangle {
\  width: 100
\  height: 100
\  color: 'red'
\
\  Rectangle {
\    width: 100
\    height: 50
\    color: 'yellow'
\    anchors.left: parent.right
\    margin.left: 20
\  }
}
```

			createMarginProp = (type) ->
				developmentSetter = (val) ->
					assert typeof val is 'number' and isFinite(val)
					, "margin.#{type} expects a finite number; `#{val}` given"

				itemUtils.defineProperty
					constructor: Margin
					name: type
					defaultValue: 0
					implementation: (val) ->
						Impl.setItemMargin.call @, type, val
					namespace: 'margin'
					parentConstructor: Item
					developmentSetter: developmentSetter

*Float* Margin::left = 0
------------------------

### *Signal* Margin::leftChanged(*Float* oldValue)

			createMarginProp 'left'

*Float* Margin::top = 0
-----------------------

### *Signal* Margin::topChanged(*Float* oldValue)

			createMarginProp 'top'

*Float* Margin::right = 0
-------------------------

### *Signal* Margin::rightChanged(*Float* oldValue)

			createMarginProp 'right'

*Float* Margin::bottom = 0
--------------------------

### *Signal* Margin::bottomChanged(*Float* oldValue)

			createMarginProp 'bottom'

*Float* Margin::valueOf()
--------------------------

Returns a float if all margin values are equal, otherwise an error is raised.

```
Item {
  margin: 10
  margin.left: 10
  onReady: function(){
  	console.log(+this.margin);
  	// 10
  }
}
```

			valueOf: ->
				if @left is @top and @top is @right and @right is @bottom
					@left
				else
					throw new Error "Margin values are different"

*Item* Item()
-------------

*Item.Margin* Item::margin
--------------------------

### *Signal* Item::marginChanged(*Item.Margin* margin)

		itemUtils.defineProperty
			constructor: Item
			name: 'margin'
			valueConstructor: Margin
			setter: (_super) -> (val) ->
				{margin} = @
				if utils.isObject(val)
					margin.left = val.left if val.left?
					margin.top = val.top if val.top?
					margin.right = val.right if val.right?
					margin.bottom = val.bottom if val.bottom?
				else
					margin.left = margin.top = margin.right = margin.bottom = val
				_super.call @, val
				return

		Margin
