Item @class
===========

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

		constructor: (component, opts) ->
			assert.instanceOf @, Item, 'ctor ...'

			@_$ = null
			@_parent = null
			@_children = null
			@_previousSibling = null
			@_nextSibling = null
			@_width = 0
			@_height = 0
			@_x = 0
			@_y = 0
			@_z = 0
			@_visible = true
			@_clip = false
			@_scale = 1
			@_rotation = 0
			@_opacity = 1
			@_linkUri = ''
			@_anchors = null
			@_layout = null
			@_document = null
			@_keys = null
			@_pointer = null
			@_margin = null
			@_padding = null
			@_classes = null
			@_background = null
			@_defaultBackground = null
			super component, opts

#### Custom properties

```
Item {
\  id: main
\  property $.currentLife: 0.8
\
\  Text {
\    text: "Life: " + main.$.currentLife
\  }  
}
```

#### Custom signals

```
Item {
\  signal $.onPlayerCollision
\  $.onPlayerCollision: function(){
\    // boom!
\  }
}
```

		utils.defineProperty @::, '$', null, ->
			@_$ ||= new itemUtils.CustomObject(@)
		, null

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

		signal.Emitter.createSignal @, 'onReady'

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
					emitSignal item, 'onUpdate', ms
				requestAnimationFrame frame

			requestAnimationFrame? frame

			(item) ->
				items.push item

*ReadOnly* *String* Item::id
----------------------------

*Object* Item::children
-----------------------

		utils.defineProperty @::, 'children', null, ->
			@_children ||= new ChildrenObject(@)
		, (val) ->
			assert.isArray val, '::children setter ...'
			@clear()
			for item in val
				val.parent = @
			return

### *Signal* Item::onChildrenChange(*Object* children)

		signal.Emitter.createSignal @, 'onChildrenChange'

		class ChildrenObject extends itemUtils.MutableDeepObject
			constructor: (ref) ->
				@_layout = null
				@_target = null
				@length = 0
				super ref

*ReadOnly* *Integer* Item::children::length
-------------------------------------------

*Item* Item::children::layout
-----------------------------

### *Signal* Item::children::onLayoutChange(*Item* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'layout'
				defaultValue: null
				developmentSetter: (val) ->
					if val?
						assert.instanceOf val, Item
				setter: (_super) -> (val) ->
					if @_layout?.effectItem
						@_layout.parent = null
						@_layout.effectItem = @_layout

					_super.call @, val

					if '_effectItem' of @_ref
						@_ref.effectItem = if val then null else @_ref

					if val?
						ref = @_ref
						setFakeParent val, ref, 0
						if val.effectItem
							val.effectItem = ref

					return

*Item* Item::children::target
-----------------------------

### *Signal* Item::children::onTargetChange(*Item* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'target'
				defaultValue: null
				developmentSetter: (val) ->
					if val?
						assert.instanceOf val, Item

*Integer* Item::children::index(*Item* value)
---------------------------------------------

			index: (val) -> Array::indexOf.call @, val

*Boolean* Item::children::has(*Item* value)
-------------------------------------------

			has: (val) -> @index(val) isnt -1
			indexOf: @::index

Item::children::clear()
-----------------------

Removes all children from a node.

			clear: ->
				while child = @[0]
					child.parent = null
				return

### *Signal* Item::children::onInsert(*Item* child, *Integer* index)

#### Listen on an item child insertion @snippet

```
Item {
\  children.onInsert: function(child){
\    child.x *= 2;
\  }
}
```

			signal.Emitter.createSignal @, 'onInsert'

### *Signal* Item::children::onPop(*Item* child, *Integer* index)

			signal.Emitter.createSignal @, 'onPop'

*Item* Item::parent = null
--------------------------

### *Signal* Item::onParentChange(*Item* oldParent)

		{indexOf, splice, push, shift, pop} = Array::

		setFakeParent = (child, parent, index=-1) ->
			oldParent = child._parent
			child.parent = null

			child._parent = parent
			Impl.setItemParent.call child, parent
			if index >= 0
				Impl.setItemIndex.call child, index
			emitSignal child, 'onParentChange', oldParent
			return

		itemUtils.defineProperty
			constructor: @
			name: 'parent'
			defaultValue: null
			setter: (_super) -> (val=null) ->
				old = @_parent
				oldChildren = old?.children
				valChildren = val?.children

				if valChildren?._target
					val = valChildren._target
					valChildren = val.children

				if old is val
					return

				# fake parent
				if @_effectItem and @_effectItem isnt @
					@_parent = val
					Impl.setItemParent.call @, val
					emitSignal @, 'onParentChange', old
					return

				assert.isNot @, val

				if pointer = @_pointer
					pointer.hover = pointer.pressed = false

				oldPreviousSibling = @_previousSibling
				oldNextSibling = @_nextSibling

				if old isnt null
					if oldNextSibling is null
						index = oldChildren.length - 1
						assert.ok oldChildren[index] is @
						pop.call oldChildren
					else if oldPreviousSibling is null
						index = 0
						assert.ok oldChildren[index] is @
						shift.call oldChildren
					else
						index = indexOf.call oldChildren, @
						assert.ok index isnt -1
						splice.call oldChildren, index, 1

				if val isnt null
					assert.instanceOf val, Item, '::parent setter ...'
					length = push.call valChildren, @

				# old siblings
				if oldPreviousSibling isnt null
					oldPreviousSibling._nextSibling = oldNextSibling
				if oldNextSibling isnt null
					oldNextSibling._previousSibling = oldPreviousSibling

				# new siblings
				if val isnt null
					previousSibling = valChildren[valChildren.length - 2] or null
					@_previousSibling = previousSibling
					previousSibling?._nextSibling = @
				else
					@_previousSibling = null
				if oldNextSibling isnt null
					@_nextSibling = null

				# parent
				@_parent = val
				Impl.setItemParent.call @, val

				# signals
				if old isnt null
					emitSignal old, 'onChildrenChange', oldChildren
					emitSignal oldChildren, 'onPop', @, index
				if val isnt null
					emitSignal val, 'onChildrenChange', valChildren
					emitSignal valChildren, 'onInsert', @, length - 1

				emitSignal @, 'onParentChange', old

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
		, (val) ->
			if val is @_previousSibling
				return

			if val
				assert.instanceOf val, Item
				if @_parent isnt val._parent
					@parent = val.parent
				@index = val.index + 1
			else
				@index = 0

### *Signal* Item::onPreviousSiblingChange(*Item* oldValue)

		signal.Emitter.createSignal @, 'onPreviousSiblingChange'

*Item* Item::nextSibling
------------------------

		utils.defineProperty @::, 'nextSibling', null, ->
			@_nextSibling
		, (val) ->
			if val is @_nextSibling
				return

			if val
				assert.instanceOf val, Item
				if @_parent isnt val._parent
					@parent = val.parent
				@index = val.index
			else if @_parent
				@index = @_parent.children.length

### *Signal* Item::onNextSiblingChange(*Item* oldValue)

		signal.Emitter.createSignal @, 'onNextSiblingChange'

*Integer* Item::index
---------------------

		utils.defineProperty @::, 'index', null, ->
			@_parent?.children.index(@) or 0
		, (val) ->
			assert.isInteger val
			assert.operator val, '>=', 0

			parent = @_parent
			if not parent
				return

			{index} = @
			children = parent._children
			if val > children.length
				val = children.length
			if index is val or index is val-1
				return

			oldPreviousSibling = @_previousSibling
			oldNextSibling = @_nextSibling

			# implementation
			Impl.setItemIndex.call @, val

			# current siblings
			oldPreviousSibling?._nextSibling = oldNextSibling
			oldNextSibling?._previousSibling = oldPreviousSibling

			# children array
			Array::splice.call children, index, 1
			if val > index
				val--
			Array::splice.call children, val, 0, @

			# new siblings
			previousSibling = children[val-1] or null
			previousSiblingOldNextSibling = previousSibling?._nextSibling
			nextSibling = children[val+1] or null
			nextSiblingOldPreviousSibling = nextSibling?._previousSibling
			@_previousSibling = previousSibling
			@_nextSibling = nextSibling
			previousSibling?._nextSibling = @
			nextSibling?._previousSibling = @

			{index} = @
			assert.is index, val
			assert.is children[index], @
			assert.is children[index-1] or null, @_previousSibling
			assert.is children[index+1] or null, @_nextSibling
			if @_previousSibling
				assert.is @_previousSibling._nextSibling, @
			else
				assert.is index, 0
			if @_nextSibling
				assert.is @_nextSibling._previousSibling, @
			else
				assert.is index, children.length - 1
			if oldPreviousSibling
				assert.is oldPreviousSibling._nextSibling, oldNextSibling
			if oldNextSibling
				assert.is oldNextSibling._previousSibling, oldPreviousSibling

			# children signal
			emitSignal parent, 'onChildrenChange', children

			# current siblings signals
			if oldPreviousSibling
				emitSignal oldPreviousSibling, 'onNextSiblingChange', @
			if oldNextSibling
				emitSignal oldNextSibling, 'onPreviousSiblingChange', @

			# new siblings signals
			emitSignal @, 'onPreviousSiblingChange', oldPreviousSibling
			if previousSibling
				emitSignal previousSibling, 'onNextSiblingChange', previousSiblingOldNextSibling
			emitSignal @, 'onNextSiblingChange', oldNextSibling
			if nextSibling
				emitSignal nextSibling, 'onPreviousSiblingChange', nextSiblingOldPreviousSibling

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

*Item* Item::background = *Rectangle*
-------------------------------------

### *Signal* Item::onBackgroundChange(*Item* oldValue)

		defaultBackgroundClass = do ->
			ext = new Renderer.Class new Renderer.Component
			ext.priority = -1
			ext.changes.setAttribute 'anchors.fill', ['parent']
			ext.changes.setAttribute 'anchors.left', ['parent', 'left']
			ext.changes.setAttribute 'anchors.top', ['parent', 'top']
			ext

		createDefaultBackground = (parent) ->
			rect = new Renderer.Rectangle parent._component
			ext = defaultBackgroundClass.clone parent._component
			ext.target = rect
			ext.enable()
			rect

		itemUtils.defineProperty
			constructor: @
			name: 'background'
			defaultValue: null
			developmentSetter: (val) ->
				if val?
					assert.instanceOf val, Item
			getter: (_super) -> ->
				unless @_background
					@_defaultBackground ||= createDefaultBackground @
					@background = @_defaultBackground
				_super.call @
			setter: (_super) -> (val) ->
				val ||= @_defaultBackground
				oldParent = val._parent
				val.parent = null
				val._parent = @
				emitSignal val, 'onParentChange', oldParent
				Impl.setItemBackground.call @, val
				_super.call @, val

Item::overlap(*Renderer.Item* item)
-----------------------------------

This method checks whether two items are overlapped.

		overlap: (item) ->
			assert.instanceOf item, Item

			Impl.doItemOverlap.call @, item

		# cloneDeep: (component) ->
		# 	clone = @clone component

		# 	for child in @children
		# 		cloneChild = child.cloneDeep component
		# 		cloneChild.parent = clone

		# 	clone

		@Spacing = require('./item/spacing') Renderer, Impl, itemUtils, Item
		@Alignment = require('./item/alignment') Renderer, Impl, itemUtils, Item
		@Anchors = require('./item/anchors') Renderer, Impl, itemUtils, Item
		@Layout = require('./item/layout') Renderer, Impl, itemUtils, Item
		@Margin = require('./item/margin') Renderer, Impl, itemUtils, Item
		@Pointer = require('./item/pointer') Renderer, Impl, itemUtils, Item
		@Keys = require('./item/keys') Renderer, Impl, itemUtils, Item
		@Document = require('./item/document') Renderer, Impl, itemUtils, Item

*Anchors* Item::anchors
-----------------------

### *Signal* Item::onAnchorsChange(*Anchors* anchors)

		@Anchors @

*Layout* Item::layout
---------------------

### *Signal* Item::onLayoutChange(*Anchors* layout)

		@Layout @

*Pointer* Item::pointer
-----------------------

		@Pointer @

*Margin* Item::margin
---------------------

### *Signal* Item::onMarginChange(*Margin* margin)

		@Margin @

*Margin* Item::padding
----------------------

### *Signal* Item::onPaddingChange(*Margin* padding)

		@Margin @,
			propertyName: 'padding'

*Keys* Item::keys
-----------------

		@Keys @

*Document* Item::document
-------------------------

		@Document @

		Item
