Margin @extension
=================

	'use strict'

	expect = require 'expect'
	utils = require 'utils'
	signal = require 'signal'
	assert = require 'assert'

	module.exports = (Renderer, Impl, itemUtils, Item) -> (ctor, opts) -> class Margin extends itemUtils.DeepObject
		@__name__ = 'Margin'

		propertyName = opts?.propertyName or 'margin'

		itemUtils.defineProperty
			constructor: ctor
			name: propertyName
			valueConstructor: Margin
			setter: (_super) -> (val) ->
				margin = @[propertyName]
				if typeof val is 'string'
					arr = val.split ' '
					for elem, i in arr
						arr[i] = parseFloat elem
					switch arr.length
						when 3
							margin.top = arr[0]
							margin.right = arr[1]
							margin.bottom = arr[2]
							margin.left = arr[1]
						when 2
							margin.top = arr[0]
							margin.right = arr[1]
							margin.bottom = arr[0]
							margin.left = arr[1]
						when 1
							margin.left = margin.top = margin.right = margin.bottom = arr[0]
						else
							margin.top = arr[0]
							margin.right = arr[1]
							margin.bottom = arr[2]
							margin.left = arr[3]
				else if utils.isObject(val)
					margin.left = val.left if val.left?
					margin.top = val.top if val.top?
					margin.right = val.right if val.right?
					margin.bottom = val.bottom if val.bottom?
				else
					margin.left = margin.top = margin.right = margin.bottom = val
				_super.call @, val
				return

		ctor::clone = do (_super = ctor::clone) -> ->
			clone = _super.call @
			if @['_' + propertyName]
				clone[propertyName] = @[propertyName]
			clone

		constructor: (ref) ->
			@_left = 0
			@_top = 0
			@_right = 0
			@_bottom = 0
			super ref

*Margin* Margin()
-----------------

Margins are used to move an item in **anchors** and in positioning items
([Renderer.Column][], [Renderer.Row][] and [Renderer.Grid][]).

#### Margins in Column items @snippet

```style
Column {
  Rectangle { color: 'red'; width: 50; height: 50; }
  Rectangle { color: 'yellow'; width: 50; height: 50; margin.top: 20; }
  Rectangle { color: 'green'; width: 50; height: 50; }
}
```

#### Margin in anchored items @snippet

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

		implMethod = Impl["set#{ctor.__name__}Margin"]
		createMarginProp = (type, extraProp) ->
			developmentSetter = (val) ->
				assert typeof val is 'number' and isFinite(val)
				, "margin.#{type} expects a finite number; `#{val}` given"

			extraPropSignal = "on#{utils.capitalize(extraProp)}Change"
			itemUtils.defineProperty
				constructor: Margin
				name: type
				defaultValue: 0
				implementation: (val) ->
					implMethod.call @, type, val
				setter: (_super) -> (val) ->
					extraOldVal = @[extraProp]
					_super.call @, val
					@[extraPropSignal].emit extraOldVal
				namespace: propertyName
				parentConstructor: ctor
				developmentSetter: developmentSetter

*Float* Margin::left = 0
------------------------

### *Signal* Margin::onLeftChange(*Float* oldValue)

		createMarginProp 'left', 'horizontal'

*Float* Margin::top = 0
-----------------------

### *Signal* Margin::onTopChange(*Float* oldValue)

		createMarginProp 'top', 'vertical'

*Float* Margin::right = 0
-------------------------

### *Signal* Margin::onRightChange(*Float* oldValue)

		createMarginProp 'right', 'horizontal'

*Float* Margin::bottom = 0
--------------------------

### *Signal* Margin::onBottomChange(*Float* oldValue)

		createMarginProp 'bottom', 'vertical'

*Float* Margin::horizontal = 0
------------------------------

### *Signal* Margin::onHorizontalChange(*Float* oldValue)

		signal.Emitter.createSignal @, 'onHorizontalChange'

		utils.defineProperty @::, 'horizontal', null, ->
			@_left + @_right
		, (val) ->
			@left = @right = val / 2

*Float* Margin::vertical = 0
----------------------------

### *Signal* Margin::onVerticalChange(*Float* oldValue)

		signal.Emitter.createSignal @, 'onVerticalChange'

		utils.defineProperty @::, 'vertical', null, ->
			@_top + @_bottom
		, (val) ->
			@top = @bottom = val / 2

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
				throw new Error "margin values are different"

		toJSON: ->
			left: @left
			top: @top
			right: @right
			bottom: @bottom
