Item @class
====

	'use strict'

	assert = require 'neft-assert'
	utils = require 'utils'
	signal = require 'signal'
	List = require 'list'

	{isArray} = Array
	{emitSignal} = signal.Emitter

	assert = assert.scope 'Renderer.Item'

	module.exports = (Renderer, Impl, itemUtils) -> class Item extends itemUtils.Object
		@__name__ = 'Item'
		@__path__ = 'Renderer.Item'

*Item* Item()
-------------

This is a base class for everything which is visible.

		constructor: ->
			assert.instanceOf @, Item, 'ctor ...'

			@constructor = @constructor
			@$ = null
			@_impl = null
			@_parent = null
			@_sourceItem = null
			@_children = null
			@_previousSibling = null
			@_nextSibling = null
			@_x = 0
			@_y = 0
			@_z = 0
			@_width = 0
			@_height = 0
			@_visible = true
			@_clip = false
			@_scale = 1
			@_rotation = 0
			@_opacity = 1
			@_linkUri = ''
			@_fill = null
			@_anchors = null
			@_document = null
			@_keys = null
			@_pointer = null
			@_margin = null
			@_classes = null
			@_classExtensions = null
			@_classList = []
			@_classQueue = []

			super()

			Impl.createObject @, @constructor.__name__

*Item* Item.create([*Object* options])
--------------------------------------

		@create = (opts) ->
			if opts?
				assert.isObject opts

			item = new @

			if opts?
				classElem = new Renderer.Class
				classElem.priority = 0
				classElem.target = item

				{changes} = classElem
				for prop, val of opts
					if typeof val is 'function' and signal.isHandlerName(prop)
						changes.setFunction prop, val
					else
						changes.setAttribute prop, val

				classElem._isReady = true
				classElem.onReady.emit()
				classElem.onReady.disconnectAll()

			item._isReady = true
			item.onReady.emit()
			item.onReady.disconnectAll()

			item

*Signal* Item::ready()
----------------------

This signal is called when the *Renderer.Item* is ready, that is, all
properties have been set and it's ready to use.

```style
Rectangle {
\  width: 200
\  height: 50
\  color: 'green'
\
\  Rectangle {
\  	width: parent.width / 2
\  	height: parent.height / 2
\  	color: 'yellow'
\  	onReady: function(){
\  	  console.log(this.width, this.height);
\  	  // 100, 25
\  	}
\  }
}
```

*Signal* Item::onUpdate(*Integer* miliseconds)
----------------------------------------------

		signal.Emitter.createSignal @, 'onUpdate', do ->
			now = Date.now()
			items = []

			frame = ->
				oldNow = now
				now = Date.now()
				ms = now - oldNow

				for item in items
					if item._isReady
						item.onUpdate.emit ms
				requestAnimationFrame frame

			requestAnimationFrame? frame

			(item) ->
				items.push item

*Object* Item::children
-----------------------

		utils.defineProperty @::, 'children', null, ->
			@_children ?= new ChildrenObject(@)
		, (val) ->
			assert.isArray val, '::children setter ...'
			@clear()
			for item in val
				val.parent = @
			return

### *Signal* Item::onChildrenChange(*Object* children)

		signal.Emitter.createSignal @, 'onChildrenChange'

		class ChildrenObject extends signal.Emitter
			constructor: (ref) ->
				@_ref = ref
				@length = 0
				super()

			index: (val) -> Array::indexOf.call @, val
			has: (val) -> @index(val) isnt -1
			indexOf: @::index

### *Signal* Item.children::onInsert(*Item* child, *Integer* index)

#### Listen on an item child insertion @snippet

```
Item {
\  children.onInsert: function(child){
\    child.x *= 2;
\  }
}
```

		signal.Emitter.createSignal ChildrenObject, 'onInsert'

### *Signal* Item.children::onPop(*Item* child, *Integer* index)

		signal.Emitter.createSignal ChildrenObject, 'onPop'

*Item* Item::parent = null
--------------------------

### *Signal* Item::onParentChange(*Item* oldParent)

		{indexOf, splice, push, shift, pop} = Array::

		itemUtils.defineProperty
			constructor: @
			name: 'parent'
			defaultValue: null
			implementation: Impl.setItemParent
			setter: (_super) -> (val=null) ->
				if val?._sourceItem
					val = val._sourceItem

				old = @_parent
				if old is val
					return

				assert.isNot @, val

				oldPreviousSibling = @_previousSibling
				oldNextSibling = @_nextSibling

				if old isnt null
					if oldNextSibling is null
						index = old._children.length - 1
						assert.ok old._children[index] is @
						pop.call old._children
					else if oldPreviousSibling is null
						index = 0
						assert.ok old._children[index] is @
						shift.call old._children
					else
						index = indexOf.call old._children, @
						assert.ok index isnt -1
						splice.call old._children, index, 1

				if val isnt null
					assert.instanceOf val, Item, '::parent setter ...'
					length = push.call val.children, @

				# old siblings
				if oldPreviousSibling isnt null
					oldPreviousSibling._nextSibling = oldNextSibling
				if oldNextSibling isnt null
					oldNextSibling._previousSibling = oldPreviousSibling

				# new siblings
				if val isnt null
					previousSibling = val._children[val._children.length - 2] or null
					@_previousSibling = previousSibling
					previousSibling?._nextSibling = @
				else
					@_previousSibling = null
				if oldNextSibling isnt null
					@_nextSibling = null

				_super.call @, val

				if old isnt null
					emitSignal old, 'onChildrenChange', old.children
					emitSignal old.children, 'onPop', @, index
				if val isnt null
					emitSignal val, 'onChildrenChange', val.children
					emitSignal val.children, 'onInsert', @, length - 1

				if oldPreviousSibling isnt null
					emitSignal oldPreviousSibling, 'onNextSiblingChange', @
				if oldNextSibling isnt null
					emitSignal oldNextSibling, 'onPreviousSiblingChange', @

				if val isnt null or oldPreviousSibling isnt null
					if previousSibling?
						emitSignal previousSibling, 'onNextSiblingChange', null
					emitSignal @, 'onPreviousSiblingChange', oldPreviousSibling
				if oldNextSibling isnt null
					emitSignal @, 'onNextSiblingChange', oldNextSibling

				return

*Item* Item::previousSibling
----------------------------

		utils.defineProperty @::, 'previousSibling', null, ->
			@_previousSibling
		, null

### *Signal* Item::onPreviousSiblingChange(*Item* oldValue)

		signal.Emitter.createSignal @, 'onPreviousSiblingChange'

*Item* Item::nextSibling
------------------------

		utils.defineProperty @::, 'nextSibling', null, ->
			@_nextSibling
		, null

### *Signal* Item::onNextSiblingChange(*Item* oldValue)

		signal.Emitter.createSignal @, 'onNextSiblingChange'

*Integer* Item::index
---------------------

		utils.defineProperty @::, 'index', null, ->
			@_parent?.children.index(@) or 0
		, (val) ->
			assert.isInteger val
			assert.operator val, '>=', 0

			{index} = @
			parent = @_parent
			if index is val or not parent
				return
			children = parent._children
			if children.length <= val
				val = children.length - 1

			# current siblings
			@_previousSibling?._nextSibling = @_nextSibling
			@_nextSibling?._previousSibling = @_previousSibling

			# new siblings
			@_previousSibling = children[val-1] or null
			@_nextSibling = children[val] or null
			@_previousSibling?._nextSibling = @
			@_nextSibling?._previousSibling = @

			# current siblings signals
			emitSignal @, 'onPreviousSiblingChange', children[index-1]
			emitSignal @, 'nextSiblingChange', children[index+1]

			# new siblings signals
			if obj = children[index-1]
				emitSignal obj, 'onNextSiblingChange', @
			if obj = children[index+1]
				emitSignal obj, 'onPreviousSiblingChange', @

			# implementation
			tmp = []
			Impl.setItemParent.call @, null
			for i in [val...children.length] by 1
				child = children[i]
				if child isnt @
					Impl.setItemParent.call child, null
					tmp.push child

			Impl.setItemParent.call @, parent
			for item in tmp
				Impl.setItemParent.call item, parent

			# children array
			Array::splice.call children, index, 1
			if val > index
				val--

			Array::splice.call children, val, 0, @

			return

*Boolean* Item::visible = true
------------------------------

Determines whether an item is visible or not.

#### Manage an item visibility @snippet

```style
Item {
\  width: 100
\  height: 100
\
\  pointer.onClicked: function(){
\  	rect.visible = !rect.visible;
\  	text.text = rect.visible ? "Click to hide" : "Click to show";
\  }
\
\  Rectangle {
\  	id: rect
\  	anchors.fill: parent
\  	color: 'blue'
\  }
\
\  Text {
\  	id: text
\  	text: "Click to hide"
\  	anchors.centerIn: parent
\  }
}
```

### *Signal* Item::onVisibleChange(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'visible'
			defaultValue: true
			implementation: Impl.setItemVisible
			developmentSetter: (val) ->
				assert.isBoolean val, '::visible setter ...'

*Boolean* Item::clip = false
----------------------------

### *Signal* Item::onClipChange(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'clip'
			defaultValue: false
			implementation: Impl.setItemClip
			developmentSetter: (val) ->
				assert.isBoolean val, '::clip setter ...'

*Float* Item::width = 0
-----------------------

### *Signal* Item::onWidthChange(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'width'
			defaultValue: 0
			implementation: Impl.setItemWidth
			developmentSetter: (val) ->
				assert.isFloat val, '::width setter ...'

*Float* Item::height = 0
------------------------

### *Signal* Item::onHeightChange(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'height'
			defaultValue: 0
			implementation: Impl.setItemHeight
			developmentSetter: (val) ->
				assert.isFloat val, '::height setter ...'

*Float* Item::x = 0
-------------------

### *Signal* Item::onXChange(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'x'
			defaultValue: 0
			implementation: Impl.setItemX
			developmentSetter: (val) ->
				assert.isFloat val, '::x setter ...'

*Float* Item::y = 0
-------------------

### *Signal* Item::onYChange(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'y'
			defaultValue: 0
			implementation: Impl.setItemY
			developmentSetter: (val) ->
				assert.isFloat val, '::y setter ...'

*Float* Item::z = 0
-------------------

### *Signal* Item::onZChange(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'z'
			defaultValue: 0
			implementation: Impl.setItemZ
			developmentSetter: (val) ->
				assert.isFloat val, '::z setter ...'

*Float* Item::scale = 1
-----------------------

### *Signal* Item::onScaleChange(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'scale'
			defaultValue: 1
			implementation: Impl.setItemScale
			developmentSetter: (val) ->
				assert.isFloat val, '::scale setter ...'

*Float* Item::rotation = 0
--------------------------

### *Signal* Item::onRotationChange(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'rotation'
			defaultValue: 0
			implementation: Impl.setItemRotation
			developmentSetter: (val) ->
				assert.isFloat val, '::rotation setter ...'

*Float* Item::opacity = 1
-------------------------

### *Signal* Item::onOpacityChange(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'opacity'
			defaultValue: 1
			implementation: Impl.setItemOpacity
			developmentSetter: (val) ->
				assert.isFloat val, '::opacity setter ...'

*String* Item::linkUri = ''
---------------------------

This attribute points to the URI which will be used when user clicks on this item.

It's required for browsers, where link URIs should be known publicly.

### *Signal* Item::onLinkUriChange(*String* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'linkUri'
			defaultValue: ''
			implementation: Impl.setItemLinkUri
			developmentSetter: (val) ->
				assert.isString val, '::linkUri setter ...'

Item::overlap(*Renderer.Item* item)
-----------------------------------

This method checks whether two items are overlapped.

		overlap: (item) ->
			assert.instanceOf item, Item

			Impl.doItemOverlap.call @, item

Item::clear()
-------------

Removes all children from a node.

		clear: ->
			while child = @children[0]
				child.parent = null
			return

Item::clone()
-------------

		clone: ->
			ctor = @constructor
			if (ctor::) is (Item::) or (ctor::) instanceof Item
				clone = new ctor
			else
				clone = ctor()

			clone.x = @_x
			clone.y = @_y
			clone.z = @_z
			clone.width = @_width
			clone.height = @_height
			clone.clip = @_clip
			clone.visible = @_visible
			clone.linkUri = @_linkUri
			clone.scale = @_scale
			clone.rotation = @_rotation
			clone.opacity = @_opacity

			clone

		@Spacing = require('./item/spacing') Renderer, Impl, itemUtils, Item
		@Alignment = require('./item/alignment') Renderer, Impl, itemUtils, Item
		@Anchors = require('./item/anchors') Renderer, Impl, itemUtils, Item
		@Margin = require('./item/margin') Renderer, Impl, itemUtils, Item
		@Fill = require('./item/fill') Renderer, Impl, itemUtils, Item
		require('./item/property') Renderer, Impl, itemUtils, Item
		require('./item/signal') Renderer, Impl, itemUtils, Item
		@Pointer = require('./item/pointer') Renderer, Impl, itemUtils, Item
		@Keys = require('./item/keys') Renderer, Impl, itemUtils, Item
		@Document = require('./item/document') Renderer, Impl, itemUtils, Item

*Anchors* Item::anchors
-----------------------

### *Signal* Item::onAnchorsChange(*Anchors* anchors)

		@Anchors @

*Pointer* Item::pointer
-----------------------

		@Pointer @

*Margin* Item::margin
---------------------

### *Signal* Item::onMarginChange(*Margin* margin)

		@Margin @

*Fill* Item::fill
-----------------

### *Signal* Item::onFillChange(*Fill* fill)

		@Fill @

*Keys* Item::keys
-----------------

		@Keys @

*Document* Item::document
-------------------------

		@Document @

		Item
